package com.aaanh;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;

public class Sandbox {
  public static void readBooks() {
    Book[] b = null;
    try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("./output/Part2/Cartoons_Comics.csv.bin"))) {
      b = (Book[]) ois.readObject();
      for (Book book : b) {
        System.out.println(book);
      }
    } catch (FileNotFoundException e) {
      System.err.println(e);
    } catch (EOFException e) {
      System.err.println(e);
    } catch (IOException e) {
      System.err.println(e);
    } catch (ClassNotFoundException e) {
      System.err.println(e);
    } catch (Exception e) {
      System.err.println(e);
    }
  }
}
