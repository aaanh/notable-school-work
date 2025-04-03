/**
 * Filename: Program.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
using System.Diagnostics;
using Engine.Classes;
using Engine.Library;
using Microsoft.VisualBasic.FileIO;

namespace Engine;

public class Program
{
  public static void Main()
  {
    // Init console window size
    if (OperatingSystem.IsWindows())
    {
      Console.SetWindowSize(60, 60);
    }

    while (true)
    {
      Console.Clear();
      Menu.MainMenu.Show();
      int option = InputParser.ToInt();

      switch (option)
      {
        case 1:
          StartGame();
          break;
        case 2:
          Console.WriteLine("!!! Confirmation !!!\n> Do you really want to delete saved game? (y/N)");
          string choice = Console.ReadLine();
          if (choice == "y")
          {
            try
            {
              Console.WriteLine("Deleting save file");
              Thread.Sleep(500);
              FileSystem.DeleteFile("savegame.json");
              Console.WriteLine("Save file deleted successfully. Returning to main menu.");
              Thread.Sleep(1000);
            }
            catch (Exception e)
            {
              Console.WriteLine("(!) Failed to delete save file. Maybe file does not exist or you don't have enough file permission.");
              if (DebugConfig.VerboseMode)
              {
                TextWriter errWriter = Console.Error;
                errWriter.WriteLine(e);
              }
              Console.WriteLine("Press any key to continue");
              Console.ReadLine();
            }
          }
          else
          {
            Console.WriteLine("Save file deletion aborted.");
          }

          break;
        case 3:
          Console.WriteLine("=================================================");
          Console.WriteLine("+          Exiting game. See you again.         +");
          Console.WriteLine("+ (C) 2025 Anh Hoang Nguyen <https://aaanh.com> +");
          Console.WriteLine("=================================================");
          Environment.Exit(0);
          break;
        case 9: // Hidden debug option
          DebugConfig.VerboseMode = !DebugConfig.VerboseMode;
          Console.WriteLine($"Debug mode is now {(DebugConfig.VerboseMode ? "ON" : "OFF")}");
          Thread.Sleep(1000);
          break;
        default:
          Console.WriteLine("Invalid option. Please try again.");
          Thread.Sleep(1000);
          break;
      }
    }
  }

  private static void StartGame()
  {
    // Clear console and set up game window
    Console.Clear();
    Console.CursorVisible = false;
    Console.WriteLine("============== Game Starting ===============");
    Console.WriteLine("+                                          +");
    Console.WriteLine("+          Press any key to begin...       +");
    Console.WriteLine("+                                          +");
    Console.WriteLine("============================================");
    Console.ReadKey(true);
    Console.Clear();

    // Try to load saved game
    var savedWorld = GameStateManager.LoadGame();
    World world;

    if (savedWorld != null)
    {
      Console.WriteLine("Found a saved game! Press 'L' to load it or any other key to start new game.");
      var key = Console.ReadKey(true);
      if (char.ToLower(key.KeyChar) == 'l')
      {
        world = savedWorld;
        Console.WriteLine("Game loaded successfully!");
        Thread.Sleep(1000);
      }
      else
      {
        world = CreateNewGame();
      }
    }
    else
    {
      world = CreateNewGame();
    }

    RunGameLoop(world);

    // Cleanup after game ends
    Console.Clear();
    Console.CursorVisible = true;
    Console.WriteLine("Thanks for playing!");
    Thread.Sleep(1000); // Show msg for 1s
  }

  private static World CreateNewGame()
  {
    // Get player name
    Console.Write("Enter your name: ");
    string playerName = Console.ReadLine() ?? "Player";
    Console.Clear();

    // Initialize game
    Position start = Initializer.RandomStartPosition();
    Player player = new(EntityTypeEnum.PLAYER, playerName, new List<Item>(), start);
    return new World(player);
  }

  private static void RunGameLoop(World world)
  {
    while (world.IsGameRunning)
    {
      Console.Clear();
      Console.WriteLine($"\n\n======== {world.ThePlayer.EntityName}'s Adventure ========\n");

      bool playerHasKey = world.ThePlayer.Inventory.Any(x => x.EntityName == "Key");

      world.TheWorldMap.PrintMapLayout(playerHasKey);

      MapGrid currentGrid = world.TheWorldMap.GetGridByPosition(world.ThePlayer.Coords)!;

      Console.WriteLine($"\nPlayer Position: {world.ThePlayer.Coords}");
      if (currentGrid is Room currentRoom)
      {
        Console.WriteLine("\n=== Current Location ===");
        currentRoom.PrintRoomInfo();
        Console.WriteLine("=======================");
        if (currentGrid.Entities.Count == 1)
        {
          Console.WriteLine("This room has nothing of significance to you");
        }
        else
        {
          Console.WriteLine("======== Items ========");
          Console.Write("> ");
          foreach (Entity entity in currentRoom.Entities)
          {
            if (entity.GetType() == typeof(Item))
            {
              Console.Write($"{entity.EntityName} ");
            }
          }
          Console.WriteLine("\n=======================");
        }
      }
      else
      {
        Console.WriteLine("\n=== Current Location ===");
        Console.WriteLine("Info: Just an ordinary hallway.");
        Console.WriteLine("Description: But it gives you the feelings from a horror movie.");
        Console.WriteLine("=======================");
      }

      if (world.ThePlayer.Inventory.Count > 0)
      {
        world.ThePlayer.ShowInventory();
      }


      // GAME LOOP MENU
      Console.WriteLine("\nCommands:");
      if (world.TheWorldMap.GetGridByPosition(world.ThePlayer.Coords)!.IsExit && world.ThePlayer.Inventory.Any(x => x.EntityName == "Key"))
      {
        Console.WriteLine("(x) Escape the damned place");

      }
      Console.WriteLine("(p) Pick Up Item");
      Console.WriteLine("(i) Show Inventory");
      Console.WriteLine("(w) Move Up     ");
      Console.WriteLine("(s) Move Down   ");
      Console.WriteLine("(a) Move Left   ");
      Console.WriteLine("(d) Move Right  ");
      Console.WriteLine("-------------------------------");
      Console.WriteLine("(l) Load Previous Saved State");
      Console.WriteLine("(v) Save Current State");
      Console.WriteLine("-------------------------------");
      Console.WriteLine("(q) Quit Game   ");
      Console.Write("\n> ");

      var input = Console.ReadKey(true);

      ProcessInput(world, input.KeyChar);
    }
  }

  private static void ProcessInput(World world, char input)
  {
    var currentPos = world.ThePlayer.Coords;
    Position newPos;
    var currentGrid = world.TheWorldMap.GetGridByPosition(currentPos);

    switch (char.ToLower(input))
    {
      case 'x':
        if (currentGrid!.IsExit && world.ThePlayer.Inventory.Any(x => x.EntityName == "Key"))
        {
          Console.Clear();
          Console.WriteLine("🎉 Congratulations! You've successfully escaped!");
          Console.WriteLine("You used the key to unlock the exit and complete your adventure.");
          Thread.Sleep(2000); // Show success message for 2 seconds
          world.EndGame();
          return;
        }
        else if (currentGrid!.IsExit)
        {
          Console.WriteLine("You need a key to unlock the exit!");
        }
        newPos = currentPos;
        break;
      case 'p':
        if (currentGrid is Room currentRoom)
        {
          var items = currentRoom.Entities.OfType<Item>().ToList();
          if (items.Count > 0)
          {
            // Pick up the first item in the room
            var item = items[0];
            if (currentRoom.RemoveEntity(item))
            {
              world.ThePlayer.Inventory.Add(item);
              Console.WriteLine($"Picked up {item.EntityName}");
            }
          }
          else
          {
            Console.WriteLine("No items to pick up in this room.");
          }
        }
        newPos = currentPos;
        break;
      case 'i':
        ShowInventoryMenu(world);
        newPos = currentPos;
        break;
      case 'v':
        GameStateManager.SaveGame(world);
        Console.WriteLine("Game saved successfully!");
        Thread.Sleep(1000);
        newPos = currentPos;
        break;
      case 'l':
        var savedWorld = GameStateManager.LoadGame();
        if (savedWorld != null)
        {
          world = savedWorld;
          Console.WriteLine("Game loaded successfully!");
          Thread.Sleep(1000);
        }
        else
        {
          Console.WriteLine("No saved game found!");
          Thread.Sleep(1000);
        }
        newPos = currentPos;
        break;
      case 'w':
        newPos = new Position(currentPos.PosX, currentPos.PosY - 1);
        break;
      case 's':
        newPos = new Position(currentPos.PosX, currentPos.PosY + 1);
        break;
      case 'a':
        newPos = new Position(currentPos.PosX - 1, currentPos.PosY);
        break;
      case 'd':
        newPos = new Position(currentPos.PosX + 1, currentPos.PosY);
        break;
      case 'q':
        world.EndGame();
        return;
      default:
        newPos = currentPos;
        break;
    }

    if (!newPos.Equals(currentPos))
    {
      if (!world.MovePlayer(newPos))
      {
        Console.WriteLine("Cannot move there!");
        Thread.Sleep(500);
      }
    }
  }

  private static void ShowInventoryMenu(World world)
  {
    if (world.ThePlayer.Inventory.Count == 0)
    {
      Console.WriteLine("You're a broke ass *****!");
      Thread.Sleep(1000);
      return;
    }

    int currentIndex = 0;
    bool inInventoryMenu = true;

    while (inInventoryMenu)
    {
      Console.Clear();
      Console.WriteLine("======== Inventory Menu ========");
      Console.WriteLine("Use W/S to navigate, ESC to exit");
      Console.WriteLine("================================");

      for (int i = 0; i < world.ThePlayer.Inventory.Count; i++)
      {
        var item = world.ThePlayer.Inventory[i];
        string prefix = i == currentIndex ? "> " : "  ";
        Console.WriteLine($"{prefix}{item.EntityName}");
      }

      Console.WriteLine("================================");
      Console.WriteLine(world.ThePlayer.Inventory[currentIndex].ItemDescription);
      Console.WriteLine("================================");

      var input = Console.ReadKey(true);
      switch (char.ToLower(input.KeyChar))
      {
        case 'w':
          currentIndex = (currentIndex - 1 + world.ThePlayer.Inventory.Count) % world.ThePlayer.Inventory.Count;
          break;
        case 's':
          currentIndex = (currentIndex + 1) % world.ThePlayer.Inventory.Count;
          break;
        case (char)27: // ESC key
          inInventoryMenu = false;
          break;
      }
    }
  }
}