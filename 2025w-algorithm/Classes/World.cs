/**
 * Filename: World.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
using Engine.Classes;
using Engine.Library;

namespace Engine.Classes;

public class World
{
  public WorldMap TheWorldMap { get; }
  public Player ThePlayer { get; }
  public bool IsGameRunning { get; private set; } = true;

  public World(Player player)
  {
    ThePlayer = player;
    TheWorldMap = Initializer.MakeWorld();

    // Initialize rooms
    List<Room> rooms = Initializer.MakeRooms(player);

    foreach (var room in rooms)
    {
      int x = room.Coords.PosX;
      int y = room.Coords.PosY;
      TheWorldMap.MapLayout[y][x] = room;
      if (DebugConfig.VerboseMode) Console.WriteLine($"Added room '{room.RoomTitle}' at position {x},{y}");
    }

    // Add player to starting position
    var startGrid = TheWorldMap.GetGridByPosition(player.Coords);
    if (startGrid is Room startRoom)
    {
      if (DebugConfig.VerboseMode) Console.WriteLine($"Player starting in room: {startRoom.RoomTitle}");
    }
    startGrid?.AddEntity(player);

    // Create key item
    _ = Initializer.MakeKey(TheWorldMap);
    _ = Initializer.MakeRandomItems(this, rooms);
    _ = Initializer.MakeExit(this);

    if (DebugConfig.VerboseMode)
    {
      Console.WriteLine("Press any key to continue..."); // Give time to see debug info
      Console.ReadKey(true);
      Console.Clear();
    }
  }

  public bool MovePlayer(Position newPosition)
  {
    if (!TheWorldMap.IsValidPosition(newPosition))
    {
      return false;
    }

    var currentGrid = TheWorldMap.GetGridByPosition(ThePlayer.Coords);
    var newGrid = TheWorldMap.GetGridByPosition(newPosition);

    if (currentGrid != null)
    {
      currentGrid.RemoveEntity(ThePlayer);
    }

    if (newGrid != null)
    {
      newGrid.AddEntity(ThePlayer);
      ThePlayer.Coords = newPosition;
      return true;
    }

    return false;
  }

  public void EndGame()
  {
    IsGameRunning = false;
  }
}
