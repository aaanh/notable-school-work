package com.aaanh.lib;

import com.aaanh.Book.Code;

public class DataValidation {
  static final long ISBN_10_WEIGHT = 1000000000L;
  static final long ISBN_13_WEIGHT = 1000000000000L;

  static boolean checkISBN(long isbn, long checksum, long weight, int factor, int type) {
    switch (type) {
      case 10:

        if (factor == 11) {
          return (checksum % 11 == 0);
        }

        double running_floor10 = Math.floor(isbn / weight);
        isbn -= running_floor10 * weight;
        checksum += running_floor10 * factor;
        weight /= 10;
        factor++;

        return checkISBN(isbn, checksum, weight, factor, type);

      case 13:
        if (weight == 0) {
          return (checksum % 10 == 0);
        }

        double running_floor13 = Math.floor(isbn / weight);
        isbn -= running_floor13 * weight;
        checksum += running_floor13 * factor;
        weight /= 10;

        if (factor == 1) {
          factor = 3;
        } else if (factor == 3) {
          factor = 1;
        }

        return checkISBN(isbn, checksum, weight, factor, type);

      default:
        return false;
    }

  }

  public static boolean validateISBN(long isbn) throws ValidationException {
    // Check if ISBN-10
    if (Long.toString(isbn).length() == 10) {
      // System.out.println(checkISBN(isbn, 0, ISBN_10_WEIGHT, 1, 10) ? "Is valid
      // ISBN-10" : "Not valid ISBN-10");
      return checkISBN(isbn, 0, ISBN_10_WEIGHT, 1, 10);
    }

    // Check if ISBN-13
    if (Long.toString(isbn).length() == 13) {
      // System.out.println(checkISBN(isbn, 0, ISBN_13_WEIGHT, 1, 13) ? "Is valid
      // ISBN-13" : "Not valid ISBN-13");
      return checkISBN(isbn, 0, ISBN_13_WEIGHT, 1, 13);
    }

    throw new ValidationException(
        "ISBN is malformed. Expected 10 or 13-digit code.\nGot " + Long.toString(isbn).length());
  }

  public static boolean validateBookCode(Code bookCode) throws InvalidBookCodeException {
    if (bookCode.equals(Code.ERR)) {
      // throw new InvalidBookCodeException();
      return false;
    }

    return true;
  }
}
