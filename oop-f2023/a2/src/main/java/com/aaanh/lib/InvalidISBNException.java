package com.aaanh.lib;

public class InvalidISBNException extends ValidationException {
  public InvalidISBNException() {
    super();
  }

  public InvalidISBNException(String msg) {
    super(msg);
  }
}
