package com.aaanh;

import java.io.IOException;
import java.util.ArrayList;

public class App {
    /**
     * Validating semantics, read the genre files each into arrays of Book objects,
     * then serialize the arrays of Book objects each into binary files.
     */
    static void Part2() {
    }

    /**
     * Reading the binary files, deserialize the array objects in each file, and
     * then provide an interacive program to allow the user to navigate the arrays.
     */
    static void Part3() {
    }

    public static void main(String[] args) {
        // Part 1
        try {
            Part1.createOutputFiles();
            Part1.parseManifest();
            Part1.parseDataFile();
            Part1.organizeBooks();
        } catch (IOException e) {
            System.err.println(e);
            System.err.println("Unknown IO exception detected.");
        } catch (Exception e) {
            System.err.println(e);
        }

        // Part 2
        try {
            Part2.createOutputFiles();
            Book[][] bookCollections = Part1.buildBookCollections();
            Part2.writeToBinary(bookCollections);
        } catch (IOException e) {
            System.err.println(e);
        } catch (Exception e) {
            System.err.println(e);
        }

        // Part 3
        Part3.start();

        // Sandbox and PoC

        // Sandbox.readBooks();

    }
}
