/**
 * Filename: Player.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
using Engine.Classes;

namespace Engine.Classes;

public class Player(EntityTypeEnum type, string entityName, List<Item> inventory, Position coords) : Entity(type, entityName)
{
  public List<Item> Inventory { get; set; } = inventory;
  public Position Coords { get; set; } = coords;

  public void ShowInventory()
  {
    Console.WriteLine("++++++++ Inventory ++++++++");
    foreach (Item item in this.Inventory)
    {
      Console.Write($"+ {item.EntityName}");
      if (Inventory.Count > 1) Console.Write($", ");
    }
    Console.WriteLine("\n+++++++++++++++++++++++++++");
  }
}
