/**
 * Filename: Item.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public class Item(EntityTypeEnum entityType, string entityName, string description) : Entity(entityType, entityName)
{
  public string ItemDescription { get; set; } = description;
}

public class Inventory(List<Entity> items) : EntityCollection(items)
{
  public List<Item> Items { get; } = items.OfType<Item>().ToList();

  public override Item? FindEntity(Entity target)
  {
    if (target is not Item searchItem)
    {
      return null;
    }

    return Items.FirstOrDefault(item =>
        item.EntityType == searchItem.EntityType &&
        item.EntityName == searchItem.EntityName);
  }

  public override bool RemoveEntity(Entity target)
  {
    var toRemove = FindEntity(target);
    if (toRemove != null)
    {
      Items.Remove(toRemove);
      return true;
    }
    return false;
  }
}