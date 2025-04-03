package com.aaanh;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.aaanh.Book.OutputFileNames;

public class Part2 {
  public static Book[] books = null;

  /**
   * Get file names under the output directory from Part 1.
   *
   * @return String[] of filenames of the text files in ./output/Part1/
   */
  static String[] getFilenames() {
    File folder = new File("./output/Part1/");
    File[] listOfFiles = folder.listFiles();
    String[] filenames = new String[listOfFiles.length];

    for (int i = 0; i < listOfFiles.length; i++) {
      filenames[i] = "./output/Part2/" + listOfFiles[i].getName() + ".bin";
    }

    return filenames;
  }

  /**
   * Create the output binary files for Part 2.
   *
   * @throws IOException
   */
  public static void createOutputFiles() throws IOException {
    Files.createDirectories(Paths.get("./output/Part2"));
    for (OutputFileNames fn : OutputFileNames.values()) {
      String fName = "./output/Part2/" + fn.toString() + ".csv.bin";
      try {
        File newFile = new File(fName);

        newFile.createNewFile();
        System.out.println("Created " + newFile.getPath());

      } catch (IOException e) {
        System.err.println("Failed to create output file.");
        System.err.println(e);
      }
    }
    return;
  }

  /**
   * From the Part 1 output of Book arrays, serialize the arrays into binary
   * files.
   *
   * @param bookCollections
   */
  public static void writeToBinary(Book[][] bookCollections) {
    String[] filenames = getFilenames();
    for (int i = 0; i < bookCollections.length; i++) {
      try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filenames[i]))) {
        oos.writeObject(bookCollections[i]);
      } catch (IOException e) {
        System.err.println(e);
      } catch (Exception e) {
        System.err.println(e);
      }
    }
  }

}
