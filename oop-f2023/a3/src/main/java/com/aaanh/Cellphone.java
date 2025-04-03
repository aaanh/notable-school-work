package com.aaanh;

import java.util.Scanner;

public class Cellphone implements Cloneable {
  private long serialNum;
  private String brand;
  private float price;
  private int year;

  public long getSerialNum() {
    return serialNum;
  }

  public void setSerialNum(long serialNum) {
    this.serialNum = serialNum;
  }

  public String getBrand() {
    return brand;
  }

  public void setBrand(String brand) {
    this.brand = brand;
  }

  public int getYear() {
    return year;
  }

  public void setYear(int year) {
    this.year = year;
  }

  public double getPrice() {
    return price;
  }

  public void setPrice(float price) {
    this.price = price;
  }

  public Cellphone() {
    serialNum = 0;
  }

  public Cellphone(long serialNum, String brand, float price, int year) {
    this.serialNum = serialNum;
    this.brand = brand;
    this.year = year;
    this.price = price;
  }

  public Cellphone(Cellphone that) {
    this.brand = that.brand;
    this.year = that.year;
    this.price = that.price;
    this.serialNum = that.serialNum;
  }

  public Cellphone(Cellphone that, long serialNum) {
    this.brand = that.brand;
    this.year = that.year;
    this.price = that.price;
    this.serialNum = serialNum;
  }

  public Cellphone clone() {
    try {
      Cellphone c = (Cellphone) super.clone();
      Scanner sc = new Scanner(System.in);
      System.out.print("Enter new serial number: ");
      long serialNum = sc.nextLong();
      c.setSerialNum(serialNum);
      return c;
    } catch (CloneNotSupportedException e) {
      e.printStackTrace();
      return null;
    }
  }

  public String toString() {
    return String.format("[%d: %s %.2f$ %d]", serialNum, brand, price, year);
  }

  public boolean equals(Object c) {
    // Pre-checks
    if (c == null || c.getClass() != this.getClass())
      return false;

    // Comparisons
    Cellphone that = (Cellphone) c;
    if (that.getBrand().equals(this.brand) && that.getYear() == this.year && that.getPrice() == this.price)
      return true;
    else
      return false;
  }
}
