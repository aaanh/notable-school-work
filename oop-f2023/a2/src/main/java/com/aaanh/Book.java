package com.aaanh;

import java.io.Serializable;
import java.util.StringJoiner;

public class Book implements Serializable {

  /**
   * Code enum constants for better DX.
   */
  public enum Code {
    CCB, HCB, MTV, MRB, NEB, OTR, SSM, ERR, TPA
  }

  /**
   * Same as above, but for the output file names.
   */
  public enum OutputFileNames {
    Cartoons_Comics, Hobbies_Collectibles, Movies_TV_Books, Music_Radio_Books,
    Nostalgia_Eclectic_Books, Old_Time_Radio_Books, Sports_Sports_Memorabilia,
    Trains_Planes_Automobiles, syntax_error_file
  }

  private String title;
  private String author;
  private double price;
  private long isbn;
  private Code bookCode;
  private int year;
  private String outputFile = "";

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getAuthor() {
    return author;
  }

  public void setAuthor(String author) {
    this.author = author;
  }

  public double getPrice() {
    return price;
  }

  public void setPrice(double price) {
    this.price = price;
  }

  public long getIsbn() {
    return isbn;
  }

  public void setIsbn(long isbn) {
    this.isbn = isbn;
  }

  public Code getBookCode() {
    return bookCode;
  }

  /**
   * Set the book code from a string with respect to the Book.Code enum
   *
   * @param code
   */
  public void setBookCode(String code) {
    Code tmpCode = Code.ERR;
    try {
      tmpCode = Code.valueOf(code);
    } catch (NullPointerException e) {
      System.err.println("Invalid Book Code");
    } finally {
      bookCode = tmpCode;
    }
  }

  public int getYear() {
    return year;
  }

  public void setYear(int year) {
    this.year = year;
  }

  public String getOutputFile() {
    return outputFile;
  }

  public void setOutputFile(String outputFile) {
    this.outputFile = outputFile;
  }

  public Book(String title, String author, double price, long isbn, Code bookCode, int year, String outFile) {
    this.title = title;
    this.author = author;
    this.price = price;
    this.isbn = isbn;
    this.bookCode = bookCode;
    this.year = year;
    this.outputFile = outFile;
  }

  public String toString() {
    // title, author, price, isbn, bookCode, year
    // Build the string that prints the book object to the console.
    StringJoiner output = new StringJoiner(",");
    output.add(title);
    output.add(author);
    output.add(Double.toString(price));
    output.add(Long.toString(isbn));
    output.add(bookCode.toString());
    output.add(Integer.toString(year));
    return output.toString();
  }

  /**
   * Map the book code to the output csv file name.
   */
  public void mapCodeToOutputCsv() {
    switch (this.bookCode) {
      // CCB, HCB, MTV, MRB, NEB, OTR, SSM, TPA, ERR
      case CCB:
        this.outputFile = OutputFileNames.Cartoons_Comics.toString() + ".csv";
        break;
      case HCB:
        this.outputFile = OutputFileNames.Hobbies_Collectibles.toString() + ".csv";
        break;
      case MTV:
        this.outputFile = OutputFileNames.Movies_TV_Books.toString() + ".csv";
        break;
      case MRB:
        this.outputFile = OutputFileNames.Music_Radio_Books.toString() + ".csv";
        break;
      case NEB:
        this.outputFile = OutputFileNames.Nostalgia_Eclectic_Books.toString() + ".csv";
        break;
      case OTR:
        this.outputFile = OutputFileNames.Old_Time_Radio_Books.toString() + ".csv";
        break;
      case SSM:
        this.outputFile = OutputFileNames.Sports_Sports_Memorabilia.toString() + ".csv";
        break;
      case TPA:
        this.outputFile = OutputFileNames.Trains_Planes_Automobiles.toString() + ".csv";
        break;
      case ERR:
      default:
        this.outputFile = OutputFileNames.syntax_error_file.toString() + ".csv";
        break;
    }
  }

}
