/**
 * Filename: GameStateManager.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
using System.Text.Json;
using Engine.Classes;

namespace Engine.Library;

public class GameStateManager
{
  private class GameState
  {
    public string PlayerName { get; set; } = "";
    public Position PlayerPosition { get; set; }
    public List<ItemState> PlayerInventory { get; set; } = [];
    public List<RoomState> Rooms { get; set; } = [];
  }

  private class ItemState
  {
    public string EntityName { get; set; } = "";
    public string ItemDescription { get; set; } = "";
  }

  private class RoomState
  {
    public Position Coords { get; set; }
    public string RoomTitle { get; set; } = "";
    public string RoomDescription { get; set; } = "";
    public List<ItemState> Items { get; set; } = [];
  }

  public static void SaveGame(World world)
  {
    var gameState = new GameState
    {
      PlayerName = world.ThePlayer.EntityName,
      PlayerPosition = world.ThePlayer.Coords,
      PlayerInventory = world.ThePlayer.Inventory.Select(item => new ItemState
      {
        EntityName = item.EntityName,
        ItemDescription = item.ItemDescription
      }).ToList(),
      Rooms = world.TheWorldMap.MapLayout
            .SelectMany(row => row)
            .Where(grid => grid is Room)
            .Select(grid => (Room)grid)
            .Select(room => new RoomState
            {
              Coords = room.Coords,
              RoomTitle = room.RoomTitle ?? "",
              RoomDescription = room.RoomDescription ?? "",
              Items = room.Entities
                    .OfType<Item>()
                    .Select(item => new ItemState
                    {
                      EntityName = item.EntityName,
                      ItemDescription = item.ItemDescription
                    }).ToList()
            }).ToList()
    };

    string jsonString = JsonSerializer.Serialize(gameState, new JsonSerializerOptions { WriteIndented = true });
    File.WriteAllText("savegame.json", jsonString);
  }

  public static World? LoadGame()
  {
    try
    {
      if (!File.Exists("savegame.json"))
      {
        return null;
      }

      string jsonString = File.ReadAllText("savegame.json");
      var gameState = JsonSerializer.Deserialize<GameState>(jsonString);

      if (gameState == null)
      {
        return null;
      }

      var playerInventory = gameState.PlayerInventory
          .Select(item => new Item(EntityTypeEnum.OBJECT, item.EntityName, item.ItemDescription))
          .ToList();
      var player = new Player(EntityTypeEnum.PLAYER, gameState.PlayerName, playerInventory, gameState.PlayerPosition);

      var world = new World(player);

      foreach (var roomState in gameState.Rooms)
      {
        var roomItems = roomState.Items
            .Select(item => new Item(EntityTypeEnum.OBJECT, item.EntityName, item.ItemDescription))
            .ToList<Entity>();
        var room = new Room(roomItems, roomState.Coords, roomState.RoomTitle, roomState.RoomDescription);
        world.TheWorldMap.MapLayout[roomState.Coords.PosY][roomState.Coords.PosX] = room;
      }

      return world;
    }
    catch (Exception)
    {
      return null;
    }
  }
}