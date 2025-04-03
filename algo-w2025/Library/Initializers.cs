/**
 * Filename: Initializers.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
using Engine.Classes;

namespace Engine.Library;

public class Initializer
{
  private const int MAP_SIZE_X = 10;
  private const int MAP_SIZE_Y = 10;


  public static List<List<MapGrid>> MakeMapLayout()
  {
    List<List<MapGrid>> mapLayout = [];

    for (int y = 0; y < MAP_SIZE_Y; y++)
    {
      mapLayout.Add([]);
      for (int x = 0; x < MAP_SIZE_X; x++)
      {
        mapLayout[y].Add(new MapGrid(new List<Entity>(), new Position(x, y)));
      }
    }

    return mapLayout;
  }

  public static WorldMap MakeWorld()
  {
    List<List<MapGrid>> mapLayout = MakeMapLayout();

    return new WorldMap(mapLayout);
  }

  public static Position RandomStartPosition()
  {
    Random rng = new();

    int x = rng.Next(0, MAP_SIZE_X);
    int y = rng.Next(0, MAP_SIZE_Y);

    return new Position(x, y);
  }

  public static List<Room> MakeRooms(Player player)
  {
    Random rng = new();
    List<Room> rooms = [];
    HashSet<Position> usedPositions = [];
    List<Deserializer.RoomDefinition> roomDefs = Deserializer.LoadRoomDefinitions();

    // Create player's starting room
    rooms.Add(new Room(
      new List<Entity>(),
      player.Coords,
      "Starting Room",
      "You find yourself in a dimly lit room of what appears to be an old mansion. You just woke up. Maybe try venturing outside the room and see what's going on here..."
    ));
    usedPositions.Add(player.Coords);
    if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Player starting position: ({player.Coords.PosX}, {player.Coords.PosY})");

    // Create a shuffled copy of room definitions
    var shuffledRooms = roomDefs.OrderBy(x => rng.Next()).ToList();

    // Calculate number of rooms to generate (excl. player's room)
    int maxRooms = MAP_SIZE_X * MAP_SIZE_Y / 2; // Use half the map size
    int numberOfRooms = rng.Next(5, maxRooms);
    if (DebugConfig.VerboseMode) Console.WriteLine($"Attempting to generate {numberOfRooms} rooms...");

    // Generate random rooms with maximum attempts to prevent infinite loop
    int maxAttempts = MAP_SIZE_X * MAP_SIZE_Y * 2;
    int attempts = 0;

    while (rooms.Count < numberOfRooms + 1 && attempts < maxAttempts && shuffledRooms.Count > 0) // +1 for player room
    {
      attempts++;
      if (DebugConfig.VerboseMode) Console.WriteLine($"Attempt: {attempts}");
      Position pos = new(rng.Next(0, MAP_SIZE_X), rng.Next(0, MAP_SIZE_Y));

      if (DebugConfig.VerboseMode)
      {
        Console.WriteLine($"Debug - Position: ({pos.PosX}, {pos.PosY})");
        Console.WriteLine($"Debug - Position already used: {usedPositions.Contains(pos)}");
        Console.WriteLine($"Debug - Available rooms: {shuffledRooms.Count}");
        Console.WriteLine($"Debug room rng check: {!usedPositions.Contains(pos) && shuffledRooms.Count > 0}");
      }
      if (!usedPositions.Contains(pos) && shuffledRooms.Count > 0)
      {
        var currentRoom = shuffledRooms[0];
        rooms.Add(new Room(
          [],
          pos,
          currentRoom.RoomTitle,
          currentRoom.RoomDescription
        ));
        usedPositions.Add(pos);
        if (DebugConfig.VerboseMode) Console.WriteLine($"Generated room {rooms.Count}: {currentRoom.RoomTitle} at {pos}");
        shuffledRooms.RemoveAt(0);
      }
    }

    if (DebugConfig.VerboseMode) Console.WriteLine($"Successfully generated {rooms.Count} rooms (including player's room)");
    return rooms;
  }

  public static Item MakeKey(WorldMap worldMap)
  {
    Random rng = new();
    Position keyPosition;
    Position playerStartPos = worldMap.MapLayout[0][0].Coords; // Get starting position

    // Keep randomizing until a non-starting grid is generated
    do
    {
      keyPosition = new Position(rng.Next(0, MAP_SIZE_X), rng.Next(0, MAP_SIZE_Y));
    } while (keyPosition.Equals(playerStartPos) || !(worldMap.GetGridByPosition(keyPosition) is Room));

    // Create the Key<Item>
    var key = new Item(EntityTypeEnum.OBJECT, "Key", "A mysterious key that might unlock something important...");

    // Add the key to the world map at the random position
    var targetGrid = worldMap.GetGridByPosition(keyPosition);
    if (targetGrid != null)
    {
      targetGrid.AddEntity(key);
      if (DebugConfig.VerboseMode)
      {
        Console.WriteLine($"Debug - Added key at position: ({keyPosition.PosX}, {keyPosition.PosY})");
      }
    }

    return key;
  }

  public static List<Item> MakeRandomItems(World world, List<Room> rooms)
  {
    Random rng = new();
    List<Item> items = [];
    List<Deserializer.ItemDefinition> itemDefs = Deserializer.LoadItemDefinitions();

    var shuffledItems = itemDefs.OrderBy(x => rng.Next()).ToList();

    // Filter out the player's starting room (first room in the list)
    var availableRooms = rooms.Skip(1).OrderBy(x => rng.Next()).ToList();

    if (DebugConfig.VerboseMode) Console.WriteLine($"Attempting to generate {shuffledItems.Count} items in {availableRooms.Count} available rooms...");

    // Place items in rooms until we run out of either items or rooms
    for (int i = 0; i < Math.Min(shuffledItems.Count, availableRooms.Count); i++)
    {
      var currentItemDef = shuffledItems[i];
      var currentRoom = availableRooms[i];
      var item = new Item(EntityTypeEnum.OBJECT, currentItemDef.EntityName, currentItemDef.ItemDescription);

      currentRoom.AddEntity(item);
      items.Add(item);

      if (DebugConfig.VerboseMode)
      {
        Console.WriteLine($"Generated item {items.Count}: {item.EntityName} in room {currentRoom.RoomTitle} at {currentRoom.Coords}");
      }
    }

    if (DebugConfig.VerboseMode)
    {
      Console.WriteLine($"Successfully generated {items.Count} items");
    }

    return items;
  }

  public static MapGrid? MakeExit(World world)
  {
    Random rng = new();
    List<MapGrid> available = [];

    // Find all available non-room positions that aren't the player's starting position
    foreach (List<MapGrid> row in world.TheWorldMap.MapLayout)
    {
      foreach (MapGrid grid in row)
      {
        if (grid.GetType() != typeof(Room) && !grid.Coords.Equals(world.ThePlayer.Coords))
        {
          available.Add(grid);
        }
      }
    }

    if (available.Count == 0)
    {
      if (DebugConfig.VerboseMode)
      {
        Console.WriteLine("Warning: No available positions for exit found!");
      }
      return null;
    }

    // Randomly select a position for the exit
    var exitPosition = available[rng.Next(available.Count)].Coords;
    var exit = new MapGrid([], exitPosition, true);

    // Update the world map with the exit
    world.TheWorldMap.MapLayout[exitPosition.PosY][exitPosition.PosX] = exit;

    if (DebugConfig.VerboseMode)
    {
      Console.WriteLine($"Created exit at position: ({exitPosition.PosX}, {exitPosition.PosY})");
    }

    return exit;
  }
}