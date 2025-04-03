package com.aaanh;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Scanner;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.aaanh.Book.OutputFileNames;
import com.aaanh.lib.DataValidation;
import com.aaanh.lib.InvalidBookCodeException;
import com.aaanh.lib.InvalidISBNException;
import com.aaanh.lib.ValidationException;

/**
 * Validating syntax, partition book records based on genre.
 */
public class Part1 {
  static String[] fileNames;
  public static Book[] books = new Book[3000];
  static int book_counter = 0;
  static String outputPath = "./output/Part1/";

  /**
   * Write the book entries in plain-text.
   *
   * @param string
   * @param filename
   */
  static void writeToFile(String string, String filename) {
    try {
      BufferedWriter bw = new BufferedWriter(new FileWriter(filename, true));
      bw.write(string);
      bw.newLine();
      bw.close();
    } catch (IOException e) {

    }
  }

  /**
   * A simple method to print the books array.
   */
  public static void printBooks() {
    for (Book b : books) {
      try {
        System.out.println(b.toString());
      } catch (NullPointerException e) {
        continue;
      }
    }
  }

  /**
   * Create the output files.
   *
   * @throws IOException
   */
  public static void createOutputFiles() throws IOException {
    Files.createDirectories(Paths.get("./output/Part1"));
    for (OutputFileNames fn : OutputFileNames.values()) {
      String fName = "./output/Part1/" + fn.toString() + ".csv";
      try {
        File newFile = new File(fName);

        if (!newFile.exists()) {
          newFile.createNewFile();
          System.out.println("Created " + newFile.getPath());
        } else {
          System.out.println("Output file exists. Skipping...");
        }

      } catch (IOException e) {
        System.err.println("Failed to create output file.");
        System.err.println(e);
      }
    }
  }

  /**
   * @throws Exception
   */
  public static void parseManifest() throws Exception {
    Scanner sc = null;

    // Manifest file
    try {
      sc = new Scanner(new FileInputStream("./assets/part1_input_file_names.csv"));
    } catch (FileNotFoundException e) {
      System.err.println("Could not open manifest file for parsing.\nPlease check if file exists.");
      System.out.println("Program will now terminate.");
      System.exit(404);
    }

    int manifestTotal = sc.nextInt();
    fileNames = new String[manifestTotal];
    sc.nextLine();
    int iFileNames = 0;

    while (sc.hasNextLine()) {
      fileNames[iFileNames] = sc.nextLine();
      iFileNames++;
    }

    sc.close();
  }

  /**
   * @throws Exception
   */
  public static void parseDataFile() throws Exception {
    for (String filename : fileNames) {
      try {
        System.out.println("\n\n>>>>>>>>> READING " + "assets/" + filename + " <<<<<<<<<<<<<<\n\n");
        BufferedReader br = new BufferedReader(new FileReader("assets/" + filename));
        parseLinesToBook(br);
        br.close();
      } catch (IOException e) {
        System.err.println("Failed to read " + "assets/" + filename);
      }
    }

    return;
  }

  /**
   * This is a dependency of {@link #parseDataFile()}. It should not be visible to
   * the operator.
   *
   * @param br
   * @throws Exception
   */
  static void parseLinesToBook(BufferedReader br) throws Exception {

    String line = br.readLine();

    while (line != null) {
      Book b = new Book("", "", 0, 0, null, 0, "");
      boolean bPartialSuccess = false;

      if (line.charAt(0) == '\"') {
        Pattern pattern = Pattern.compile("\"(.*?)\"");
        Matcher matcher = pattern.matcher(line);

        String tmp_title = "";

        while (matcher.find()) {
          tmp_title = line.substring(matcher.start(), matcher.end());
          line = line.substring(matcher.end() + 1);
          b.setTitle(tmp_title);
        }

        String[] split = line.split(",");
        if (split.length != 5) { // Length is not 5 because the matcher step has truncated the double-quoted
                                 // part.
          BufferedWriter bw = new BufferedWriter(
              new FileWriter(outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv", true));
          bw.newLine();
          bw.write("Invalid entry: Not enough fields");
          bw.newLine();
          bw.write("================================");
          bw.newLine();
          bw.write(line);
          bw.newLine();
          bw.newLine();
          bw.close();
        } else {
          try {
            b.setAuthor(split[0]);
            b.setPrice(Float.parseFloat(split[1]));
            b.setIsbn(Long.parseLong(split[2]));
            b.setBookCode(split[3]);
            b.setYear(Integer.parseInt(split[4]));
            b.mapCodeToOutputCsv();
            books[book_counter] = b;
          } catch (Exception e) {
            bPartialSuccess = true;
            b.setBookCode("ERR");
            BufferedWriter bw = new BufferedWriter(
                new FileWriter("./output/Part1/" + Book.OutputFileNames.syntax_error_file.toString() + ".csv",
                    true));
            bw.newLine();
            bw.write("Invalid Book: Malformed data");
            bw.newLine();
            bw.write("============================");
            bw.newLine();
            bw.write(line);
            bw.newLine();
            bw.close();
          }
        }
      } else { // NOT A DOUBLE-QUOTED TITLE
        String[] split = line.split(",");
        if (split.length != 6) { // Check length is 6 because we've not truncated the double-quoted part.
          BufferedWriter bw = new BufferedWriter(
              new FileWriter(outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv", true));
          bw.newLine();
          bw.write("Invalid entry: Not enough fields");
          bw.newLine();
          bw.write("================================");
          bw.newLine();
          bw.write(line);
          bw.newLine();
          bw.newLine();
          bw.close();
        } else {
          try {
            b.setTitle(split[0]);
            b.setAuthor(split[1]);
            b.setPrice(Float.parseFloat(split[2]));
            b.setIsbn(Long.parseLong(split[3]));
            b.setBookCode(split[4]);
            b.setYear(Integer.parseInt(split[5]));
            b.mapCodeToOutputCsv();
            books[book_counter] = b;
          } catch (Exception e) {
            bPartialSuccess = true;
            b.setBookCode("ERR");
            BufferedWriter bw = new BufferedWriter(
                new FileWriter("./output/Part1/" + Book.OutputFileNames.syntax_error_file.toString() + ".csv",
                    true));
            bw.newLine();
            bw.write("Invalid Book: Malformed data");
            bw.newLine();
            bw.write("============================");
            bw.newLine();
            bw.write(line);
            bw.newLine();
            bw.close();
          }
        }
      }
      book_counter++;
      bPartialSuccess = false;
      line = br.readLine();
    }
    return;
  }

  /**
   * This organize the books into their respective genres and codes.
   *
   * @throws Exception
   */
  public static void organizeBooks() {
    boolean fValidISBN = false;
    boolean fValidBookCode = false;

    Book[] parsedBooks = new Book[book_counter];

    for (int i = 0; i < parsedBooks.length; i++) {
      parsedBooks[i] = books[i];
    }

    for (Book b : parsedBooks) {
      try {
        fValidISBN = DataValidation.validateISBN(b.getIsbn());
        fValidBookCode = DataValidation.validateBookCode(b.getBookCode());

        if (!fValidISBN) {
          writeToFile("\nInvalid ISBN:\n============\n" + b.toString() + "\n",
              outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv");
          throw new InvalidISBNException(b.toString());
        }

        if (!fValidBookCode) {
          writeToFile("\nInvalid book code:\n============\n" + b.toString() + "\n",
              outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv");
          throw new InvalidBookCodeException(b.toString());
        }

        writeToFile(b.toString(), outputPath + b.getOutputFile());

      } catch (InvalidISBNException e) {
        try {
          BufferedWriter bw = new BufferedWriter(
              new FileWriter(outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv", true));
          bw.newLine();
          bw.write(e.toString());
          bw.newLine();
          bw.write("============");
          bw.newLine();
          bw.write(b.toString());
          bw.close();
        } catch (IOException e1) {
          e1.printStackTrace();
        }
      } catch (InvalidBookCodeException e) {
        try {
          BufferedWriter bw1 = new BufferedWriter(
              new FileWriter(outputPath + Book.OutputFileNames.syntax_error_file.toString() + ".csv", true));
          bw1.newLine();
          bw1.write(e.toString());
          bw1.newLine();
          bw1.write("============");
          bw1.newLine();
          bw1.write(b.toString());
          bw1.close();
        } catch (IOException e2) {
          System.err.println(e);
        }
      } catch (ValidationException e) {
        System.err.println(e);
      } catch (NullPointerException e) {
        System.err.println("Null Book object in storage array. Skipping...");
      } catch (Exception e) {
        System.err.println("Unhandled exception occurred: " + e);
      }
    }
  }

  /**
   * This method is used to build the book collections.
   *
   * @return Book[][]
   */
  public static Book[][] buildBookCollections() {
    Book[][] bookCollections = new Book[Book.Code.values().length][];
    int[][] bookCollectionLengths = new int[Book.Code.values().length][];
    for (int i = 0; i < bookCollectionLengths.length; i++) {
      int counter = 0;
      for (int j = 0; j < books.length; j++) {
        try {
          if (books[j].getBookCode() == Book.Code.values()[i]) {
            // System.out.println(books[j].getBookCode() + "\t" + Book.Code.values()[i]);
            counter++;
          }
        } catch (NullPointerException e) {
          continue;
        }
      }
      bookCollectionLengths[i] = new int[counter];
    }

    for (int i = 0; i < bookCollections.length; i++) {
      bookCollections[i] = new Book[bookCollectionLengths[i].length];
    }

    for (int i = 0; i < bookCollections.length; i++) {
      int counter = 0;
      for (int j = 0; j < books.length; j++) {
        try {
          if (books[j].getBookCode() == Book.Code.values()[i]) {
            bookCollections[i][counter] = books[j];
            counter++;
          }
        } catch (NullPointerException e) {
          continue;
        } catch (ArrayIndexOutOfBoundsException e) {
          continue;
        }
      }
    }

    // for (int i = 0; i < bookCollections.length; i++) {
    // for (int j = 0; j < bookCollections[i].length; j++) {

    // System.out.println(bookCollections[i][j].toString());

    // }
    // }

    return bookCollections;
  }

}
