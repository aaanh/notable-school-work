using System.Text.Json;

namespace Engine.Library;

// FOR DESERIALIZING FROM JSON ASSETS ONLY
public class Deserializer
{
  public class RoomDefinition
  {
    public string RoomTitle { get; set; } = "";
    public string RoomDescription { get; set; } = "";
  }

  public class RoomDefinitions
  {
    public List<RoomDefinition> Rooms { get; set; } = [];
  }

  public static List<RoomDefinition> LoadRoomDefinitions()
  {
    try
    {
      string jsonString = File.ReadAllText("assets/rooms.json");
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - JSON content: {jsonString}");
      var roomDefs = JsonSerializer.Deserialize<RoomDefinitions>(jsonString);
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Loaded {roomDefs?.Rooms.Count ?? 0} room definitions");
      var result = roomDefs?.Rooms ?? [];
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Returning {result.Count} rooms");
      return result;
    }
    catch (Exception e)
    {
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Error loading rooms: {e.Message}");
      return [];
    }
  }

  public class ItemDefinition
  {
    public string EntityName { get; set; } = "";
    public string ItemDescription { get; set; } = "";
  }

  public class ItemDefinitions
  {
    public List<ItemDefinition> Items { get; set; } = [];
  }

  public static List<ItemDefinition> LoadItemDefinitions()
  {
    try
    {
      string jsonString = File.ReadAllText("assets/items.json");
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - JSON content: {jsonString}");
      var itemDefs = JsonSerializer.Deserialize<ItemDefinitions>(jsonString);
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Loaded {itemDefs?.Items.Count ?? 0} item definitions");
      var result = itemDefs?.Items ?? [];
      return result;
    }
    catch (Exception e)
    {
      if (DebugConfig.VerboseMode) Console.WriteLine($"Debug - Error loading items: {e.Message}");
      return [];
    }
  }
}