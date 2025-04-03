/**
 * Filename: Room.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public class Room(List<Entity> entities, Position coords) : MapGrid(entities, coords)
{
  public string? RoomTitle { get; set; }
  public string? RoomDescription { get; set; }
  public Room(List<Entity> entities, Position coords, string roomTitle, string roomDescription)
    : this(entities, coords)
  {
    RoomTitle = roomTitle ?? "Generic room";
    RoomDescription = roomDescription ?? "A non-descript room. Nothing of interest seems to be here.";
  }

  public void PrintRoomInfo()
  {
    Console.WriteLine($"Room: {this.RoomTitle}");
    Console.WriteLine($"{this.RoomDescription}");
  }
}