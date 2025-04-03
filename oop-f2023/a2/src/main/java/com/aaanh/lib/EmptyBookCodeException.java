package com.aaanh.lib;

import com.aaanh.Book;

class EmptyBookCodeException extends InvalidBookCodeException {
  public EmptyBookCodeException() {
    super("Exception occurred. Empty book has empty book code.");
  }

  public EmptyBookCodeException(Book book) {
    super("Exception occurred. No Book Code was not parsed. Book <<" + book.toString() + ">>");
  }
}