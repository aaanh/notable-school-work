package com.aaanh;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class CellListUtilization {

  public static void main(String[] args) {
    CellList list1 = new CellList();
    CellList list2 = new CellList();

    String filepath = "./resources/Cell_info.txt";

    BufferedReader br;

    try {
      br = new BufferedReader(new FileReader(filepath));
      while (true) {
        String line = br.readLine();
        if (line == null)
          break;
        else {
          String[] splitted = line.split("\\s+");
          Cellphone temp = new Cellphone(Long.parseLong(splitted[0]), splitted[1], Float.parseFloat(splitted[2]),
              Integer.parseInt(splitted[3]));
          list1.addToStart(temp);
          list2.addToStart(temp);
        }
      }
    } catch (FileNotFoundException e) {
      e.printStackTrace();
      System.exit(1);
    } catch (IOException e) {
      e.printStackTrace();
      System.exit(1);
    }

    System.out.println("Compare list BEFORE mutations: " + list1.equals(list2));

    System.out.println("List 1 content BEFORE mutations");
    list1.showContents();
    System.out.println("List 2 content");
    list2.showContents();

    System.out.println("Delete a node in List 1 by Index: " + list1.deleteFromIndex(0));
    System.out.println("Check if List 1 contains s/n 6699001: " + list1.contains(6699001));
    System.out.println("Find s/n 6699001: " + list1.find(6699001));
    Cellphone c1 = new Cellphone(123456789L, "Apple", 69.42F, 2023);
    System.out.println("Created new cell to install: " + c1.toString());
    System.out.println("Insert at index 0: " + list1.insertAtIndex(c1, 0));
    System.out.println("Insert at index 0 using the same object (collision detection): "
        + list1.insertAtIndex(c1, 0));
    try {
      System.out.println("Insert at index 999 (out of bounds): "
          + list1.insertAtIndex(new Cellphone(223456789L, "Apple", 69.42F, 2023), 999));
    } catch (Exception e) {
      System.err.println(e);
    }

    System.out.println("\n> List 1 content AFTER mutations");
    list1.showContents();

    System.out.println("\nCompare list AFTER mutations: " + list1.equals(list2));
    System.out.println();
    System.out.println("Execution completed.");
    System.out.println();
  }
}
