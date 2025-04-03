/**
 * Filename: Menu.cs
 * Copyright (C) Anh Hoang Nguyen, AAANH Corporation. All rights reserved.
 */
namespace Engine.Library;

public class Menu
{
  public class MainMenu
  {
    public static void Show()
    {
      Console.WriteLine("---- Welcome to the game -----");
      Console.WriteLine(@" ____                 _                 _             _ ");
      Console.WriteLine(@"|  _ \ __ _ _ __   __| | ___  _ __ ___ (_)_______  __| |");
      Console.WriteLine(@"| |_) / _` | '_ \ / _` |/ _ \| '_ ` _ \| |_  / _ \/ _` |");
      Console.WriteLine(@"|  _ < (_| | | | | (_| | (_) | | | | | | |/ /  __/ (_| |");
      Console.WriteLine(@"|_| \_\__,_|_| |_|\__,_|\___/|_| |_| |_|_/___\___|\__,_|");
      Console.WriteLine(@"            _                                           ");
      Console.WriteLine(@"   /\      | |                 _                        ");
      Console.WriteLine(@"  /  \   _ | |_   _ ____ ____ | |_ _   _  ____ ____     ");
      Console.WriteLine(@" / /\ \ / || | | | / _  )  _ \|  _) | | |/ ___) _  )    ");
      Console.WriteLine(@"| |__| ( (_| |\ V ( (/ /| | | | |_| |_| | |  ( (/ /     ");
      Console.WriteLine(@"|______|\____| \_/ \____)_| |_|\___)____|_|   \____)    ");
      Console.WriteLine("");
      Console.WriteLine("1. Start");
      Console.WriteLine("2. Delete saved game");
      Console.WriteLine("3. Exit");
      Console.WriteLine("");
      Console.Write("> ");
    }
  }

}