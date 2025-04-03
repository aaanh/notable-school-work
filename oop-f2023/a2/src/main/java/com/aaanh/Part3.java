package com.aaanh;

import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.Scanner;

public class Part3 {
  static Book[][] bookCollections;
  static String selectedFile;
  static int selectedCollection = -1;

  /**
   * A small method that shows the menu and gets the user's selection and returns
   * it.
   *
   * @return
   */
  static String showMainMenu() {
    Scanner sc = new Scanner(System.in);

    System.out.println("------------------");
    System.out.println(" Main Menu ");
    System.out.println("------------------");
    if (selectedFile != null && selectedCollection >= 0) {
      System.out.print(" v  View the selected file: ");
      System.out.println(selectedFile + "\t(" + bookCollections[selectedCollection].length + " records)");
    } else {
      System.out.println("No file selected yet.");
    }
    System.out.println(" s  Select a file to view");
    System.out.println(" x  Exit");
    System.out.println("------------------");

    System.out.print("\n\nEnter your choice: ");

    String choice = sc.nextLine();

    return choice;
  }

  /**
   * Same thing but for the file-viewing sub menu.
   *
   * @return
   */
  static int showFileSubMenu() {
    System.out.println("----------------------");
    System.out.println("File Sub-Menu");
    System.out.println("----------------------");
    String[] filenames = getFilenames();
    for (int i = 0; i < filenames.length; i++) {
      System.out.println(i + "\t" + filenames[i] + "\t\t(" + bookCollections[i].length + " records)");
    }
    System.out.println((filenames.length + 1) + "\tExit");
    System.out.println("----------------------");

    System.out.print("Enter your choice: ");
    Scanner sc = new Scanner(System.in);
    int choice = sc.nextInt();
    sc.nextLine();
    System.out.println("Your choice: " + choice);

    return choice;
  }

  static String[] getFilenames() {
    File folder = new File("./output/Part2/");
    File[] listOfFiles = folder.listFiles();
    String[] filenames = new String[listOfFiles.length];

    for (int i = 0; i < listOfFiles.length; i++) {
      filenames[i] = "./output/Part2/" + listOfFiles[i].getName();
    }

    return filenames;
  }

  /**
   * Count the number of books in a file.
   *
   * @param filename
   * @return
   */
  static int countBooksInFile(String filename) {
    int count = 0;
    try {
      ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename));
      while (true) {
        try {
          ois.readObject();
          count++;
        } catch (EOFException e) {
          break;
        }
      }
      ois.close();
    } catch (IOException | ClassNotFoundException e) {
      e.printStackTrace();
    }
    return count;
  }

  /**
   * Read books from a file and return an array of Book objects.
   *
   * @param filename
   * @return
   */
  static Book[] readBooksFromFile(String filename) {
    Book[] b = null;
    try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
      while (true) {
        b = (Book[]) ois.readObject();
      }
    } catch (EOFException e) {
      // e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    }

    return b;
  }

  /**
   * From the binary files output from Part 2, deserialize the arrays of Book with
   * respect to each genres.
   */
  static void buildCollectionFromStorage() {
    String[] filenames = getFilenames();
    Book[][] bookCollections = new Book[filenames.length][];

    // Get length of each book collection and initialize the respsective array size
    for (int i = 0; i < filenames.length; i++) {
      int numOfBooks = countBooksInFile(filenames[i]);
      bookCollections[i] = new Book[numOfBooks];
    }

    // Read book objects and store in 2-D array bookCollections
    for (int i = 0; i < filenames.length; i++) {
      bookCollections[i] = readBooksFromFile(filenames[i]);
    }

    Part3.bookCollections = bookCollections;
  }

  /**
   * For navigating the books in one genre array.
   *
   * @param current
   * @param next
   * @return
   */
  static int navigate(int current, int next) {

    if (current + next > bookCollections[selectedCollection].length) {
      System.err.println("Cannot navigate to an index greater than the length of the array.");
      return bookCollections[selectedCollection].length;
    } else if (current + next < 0) {
      System.err.println("Cannot navigate to a negative index.");
      return 0;
    } else if (next < 0) {
      for (int i = current; i > current + next; i--) {
        System.out.println(bookCollections[selectedCollection][i].toString());
      }
      return current + next;
    } else {
      for (int i = current; i < current + next; i++) {
        System.out.println(bookCollections[selectedCollection][i].toString());
      }
      return current + next;
    }
  }

  /**
   * Part 3 entry point.
   */
  static void start() {
    buildCollectionFromStorage();

    while (true) {
      String choice = Part3.showMainMenu();
      switch (choice) {
        case "v":
          if (selectedFile == null) {
            System.out.println(selectedFile);
            System.out.println(selectedCollection);
            System.out.println("> sysctl: Illegal operation, please try again.");
          } else {
            boolean fStopViewing = false;
            int currentBook = 0;
            String filename = getFilenames()[selectedCollection];
            while (!fStopViewing) {
              System.out.println(
                  "> sysctl: Viewing \"" + filename + "\"\t(" + bookCollections[selectedCollection].length
                      + " records)");
              System.out.print("View command: ");
              Scanner sc = new Scanner(System.in);
              int next = sc.nextInt();
              if (next == 0) {
                fStopViewing = true;
                System.out.println("Exit viewing...");
                break;
              } else {
                try {
                  currentBook = navigate(currentBook, next);
                } catch (IndexOutOfBoundsException e) {
                  System.err.println(e);
                  continue;
                }
              }
              sc.nextLine();

            }
          }
          break;
        case "s":
          String[] filenames = getFilenames();
          Part3.selectedCollection = showFileSubMenu();
          Part3.selectedFile = filenames[selectedCollection];
          System.out.println("> sysctl: Selected " + selectedFile + " file to view.");
          break;
        case "x":
          System.out.println("Program will now exit...");
          System.exit(0);
          break;
        default:
          System.out.println("sysctl: Illegal operation, please try again.");
          break;
      }
    }
  }
}
