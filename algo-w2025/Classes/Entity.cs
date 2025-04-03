/**
 * Filename: Entity.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public enum EntityTypeEnum
{
  OBJECT,
  PLAYER,
}

public class Entity
{
  public EntityTypeEnum EntityType { get; set; }
  public string EntityName { get; set; }

  public Entity(EntityTypeEnum type, string entityName)
  {
    EntityType = type;
    EntityName = entityName;
  }
}

public class EntityCollection(List<Entity> entities)
{
    public List<Entity> Entities { get; set; } = entities;

    public virtual Entity? FindEntity(Entity target)
  {
    foreach (Entity entity in Entities)
    {
      if (entity.EntityType == target.EntityType && entity.EntityName == target.EntityName)
      {
        return entity;
      }
    }
    return null;
  }

  public virtual bool RemoveEntity(Entity target)
  {
    Entity? toRemove = FindEntity(target);
    if (toRemove != null)
    {
      Entities.Remove(toRemove);
      Console.WriteLine($"Removed {target.EntityName}");
      return true;
    }
    return false;
  }
}