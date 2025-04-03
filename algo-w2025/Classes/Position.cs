/**
 * Filename: Position.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Classes;

public struct Position(int posX, int posY)
{
  public int PosX { get; set; } = posX;
  public int PosY { get; set; } = posY;

  public override readonly string ToString()
  {
    return $"{PosX},{PosY}";
  }

  public override readonly bool Equals(object? obj)
  {
    if (obj is Position other)
    {
      return PosX == other.PosX && PosY == other.PosY;
    }
    return false;
  }

  public override readonly int GetHashCode()
  {
    return HashCode.Combine(PosX, PosY);
  }

  public static bool operator ==(Position left, Position right)
  {
    return left.Equals(right);
  }

  public static bool operator !=(Position left, Position right)
  {
    return !(left == right);
  }
}