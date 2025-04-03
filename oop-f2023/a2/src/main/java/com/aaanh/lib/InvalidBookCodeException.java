package com.aaanh.lib;

import com.aaanh.Book;

public class InvalidBookCodeException extends ValidationException {
    public InvalidBookCodeException() {
        super("Invalid book code detected.");
    }

    public InvalidBookCodeException(String msg) {
        super(msg);
    }

    public InvalidBookCodeException(Book book) {
        super("Exception occurred when validating book code of <<" + book.toString() + ">>");
    }
}