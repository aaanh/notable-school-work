/**
 * Filename: MapGrid.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public class MapGrid(List<Entity> entities, Position coords)
{
  public List<Entity> Entities { get; set; } = entities;
  public Position Coords { get; } = coords;
  public bool IsExit = false;

  public MapGrid(List<Entity> entities, Position coords, bool isExit) : this(entities, coords)
  {
    this.IsExit = isExit;
  }

  public bool AddEntity(Entity entity)
  {
    try
    {
      Entities.Add(entity);
      return true;
    }
    catch
    {
      return false;
    }
  }

  public bool RemoveEntity(Entity entity)
  {
    try
    {
      var toRemove = Entities.Find(x => x.EntityType == entity.EntityType && x.EntityName == entity.EntityName)
          ?? throw new Exception("Entity not found");
      return Entities.Remove(toRemove);
    }
    catch
    {
      return false;
    }
  }

  public void PrintGrid(bool playerHasKey)
  {
    if (playerHasKey && this.IsExit) { Console.Write("[X]"); return; }
    if (Entities.Count == 0)
    {
      if (this.GetType() == typeof(Room))
      {
        Console.Write("< >");
      }
      else
      {
        Console.Write("[ ]");
      }
    }
    else
    {
      var entity = Entities[0]; // Show only the first entity in the cell
      string symbol = entity.EntityType switch
      {
        EntityTypeEnum.PLAYER => "P",
        EntityTypeEnum.OBJECT => "O",
        _ => "?"
      };
      if (this.GetType() == typeof(Room))
      {
        Console.Write("<" + symbol + ">");
      }
      else
      {

        Console.Write($"[{symbol}]");
      }
    }
  }
}