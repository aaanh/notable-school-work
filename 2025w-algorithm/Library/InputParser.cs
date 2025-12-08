/**
 * Filename: InputParser.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Library;

public class InputParser
{
  public static int ToInt()
  {
    string input = Console.ReadLine()!;

    if (input == "" || input == null)
    {
      return -1;
    }

    int parsed = int.Parse(input);

    return parsed;
  }

  public static string[] SpaceSeparatedToStringArray()
  {
    string input = Console.ReadLine()!;
    string[] parsed = input.TrimEnd().Split(" ");

    return parsed;
  }
}