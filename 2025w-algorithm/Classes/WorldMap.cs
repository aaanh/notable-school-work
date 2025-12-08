/**
 * Filename: WorldMap.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public class WorldMap
{
  public List<List<MapGrid>> MapLayout { get; }

  public WorldMap(List<List<MapGrid>> mapLayout)
  {
    MapLayout = mapLayout;
  }

  public void PrintMapLayout(bool playerHasKey = false)
  {
    // Print column numbers
    Console.Write("   "); // Spacing for row numbers
    for (int x = 0; x < MapLayout[0].Count; x++)
    {
      Console.Write($" {x} ");
    }
    Console.WriteLine();

    /**
     * Example map grid print layout
          1  2  3  4  5  6
          ------------------
      1 |[ ][ ][ ][ ]<o>[ ]| 1
      2 |[ ][ ][o][ ][ ][ ]| 2
      3 |[ ][ ][ ][ ][x][ ]| 3
      4 |[ ]< >[ ][P][ ][ ]| 4
      5 |[ ][ ][ ][ ][ ][ ]| 5
      6 |[ ][ ][ ][ ][ ][ ]| 6
          ------------------
          1  2  3  4  5  6
     */

    // Top border
    Console.Write("   "); // Spacing for row nums
    for (int x = 0; x < MapLayout[0].Count; x++)
    {
      Console.Write("---");
    }
    Console.WriteLine();

    // Render rows
    for (int y = 0; y < MapLayout.Count; y++)
    {
      Console.Write($"{y} |"); // Row number
      foreach (var grid in MapLayout[y])
      {
        grid.PrintGrid(playerHasKey);
      }
      Console.WriteLine($"| {y}"); // Row number on the right
    }

    // Bottom border
    Console.Write("   "); // Spacing for row nums
    for (int x = 0; x < MapLayout[0].Count; x++)
    {
      Console.Write("---");
    }
    Console.WriteLine();

    // Col num again
    Console.Write("   "); // Spacing for row nums
    for (int x = 0; x < MapLayout[0].Count; x++)
    {
      Console.Write($" {x} ");
    }
    Console.WriteLine();
  }

  public MapGrid? GetGridByPosition(Position coords)
  {
    return MapLayout.SelectMany(row => row)
                  .FirstOrDefault(grid => grid.Coords.Equals(coords));
  }

  public bool IsValidPosition(Position position)
  {
    return position.PosX >= 0 && position.PosX < MapLayout[0].Count &&
            position.PosY >= 0 && position.PosY < MapLayout.Count;
  }
}