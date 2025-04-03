package com.aaanh;

import java.util.NoSuchElementException;

public class CellList {
  class CellNode {
    private Cellphone cell;
    private CellNode next;

    public Cellphone getCell() {
      return cell;
    }

    public void setCell(Cellphone cell) {
      this.cell = cell;
    }

    public CellNode getNext() {
      return next;
    }

    public void setNext(CellNode next) {
      this.next = next;
    }

    CellNode() {
      cell = null;
      next = null;
    }

    CellNode(Cellphone c, CellNode n) {
      this.cell = c;
      this.next = n;
    }

    CellNode(CellNode n) {
      this.cell = new Cellphone(n.getCell());
    }

    public CellNode clone() {
      try {
        CellNode cn = (CellNode) super.clone();
        cn.cell = this.cell.clone();
        return cn;
      } catch (CloneNotSupportedException e) {
        e.printStackTrace();
        return null;
      }
    }

    public CellNode getnext() {
      return next;
    }

  }

  private CellNode head;
  private int size;

  /**
   * Return a pointer to the head of the CellList
   *
   * @return
   */
  public CellNode getHead() {
    return head;
  }

  public void setHead(CellNode head) {
    this.head = head;
  }

  public int getSize() {
    return size;
  }

  public void setSize(int size) {
    this.size = size;
  }

  public CellList() {
    head = null;
    size = 0;
  }

  public CellList(CellList cl) {
    head = cl.getHead();
    size = cl.getSize();
  }

  /**
   * Create and add a new CellNode containing a Cellphone to the start of the
   * CellList. Update size after a successful operation.
   *
   * @param c a Cellphone object to be added to the start of the CellList
   * @return true or false depending on whether the operation succeeds or fails
   */
  public boolean addToStart(Cellphone c) {
    if (contains(c.getSerialNum())) {
      return false;
    } else {
      head = new CellNode(c, head);
      size++;
      return true;
    }
  }

  /**
   * Create and add a new CellNode before the specified index. Update size after a
   * successful operation.
   * Example, CellList: [a] -> [b] -> [c], add [d] at index 1 will result in
   * [a] -> [d] -> [b] -> [c]
   *
   * @param c   a Cellphone object to be added to the index of the CellList
   * @param idx index of where to insert the new node
   * @return true if succeeds, false if fails.
   */
  public boolean insertAtIndex(Cellphone c, int idx) {
    if (contains(c.getSerialNum())) {
      System.err.println("> Failed to insert at idx " + idx + ". Serial number already exists.");
      return false;
    }

    if (idx == 0) {
      addToStart(c);
      return true;
    }

    if (idx >= size || idx < 0)
      throw new NoSuchElementException("Index to insert is out of bounds.");

    CellNode temp = head;

    for (int i = 0; i < size; i++) {
      if (i == idx - 1) {
        temp.next = new CellNode(c, temp.next);
        size++;
        return true;
      } else {
        temp = temp.next;
      }
    }

    return false;
  }

  /**
   * Delete a CellNode at specified index and update the size
   *
   * @param idx Index of the node to be deleted
   * @return true if succeeds, false if fails
   */
  public boolean deleteFromIndex(int idx) {
    if (idx >= size || idx < 0)
      throw new NoSuchElementException("Index to remove is out of bounds.");

    if (idx == 0) { // Delete head
      head = head.next;
      size--;
      return true;
    }

    CellNode temp = head;
    for (int i = 0; i < size - 1; i++) {
      if (i == idx - 1) {
        temp.next = temp.next.next;
        size--;
        return true;
      }
      temp = temp.next;
    }
    return false;
  }

  /**
   * Linearly traverse the CellList using a temporary pointer to find the CellNode
   * containing a Cellphone with the specified serial number.
   *
   * @param serialNum
   * @return the address of the CellNode with the Cellphone with the matching
   *         serial number.
   */
  public CellNode find(long serialNum) {
    CellNode temp = head;

    while (true) {
      if (temp == null)
        return null;

      if (temp.cell.getSerialNum() == serialNum) {
        return temp;
      } else {
        temp = temp.next;
      }
    }
  }

  /**
   * Check if the specified serial number exists in the CellList
   *
   * @param serialNum
   * @return true or false
   */
  public boolean contains(long serialNum) {
    CellNode temp = head;

    while (true) {
      if (temp == null)
        return false;

      if (temp.cell.getSerialNum() == serialNum) {
        return true;
      } else {
        temp = temp.next;
      }
    }
  }

  /**
   * Linearly traverse and display every Cellphone object stored in the CellList
   */
  public void showContents() {
    CellNode temp = head;
    System.out.println("\nThe current size of the list is " + size + ". Here are the contents of the list");
    System.out.println("================================================================================");
    for (int i = 0; i < size; i++) {
      if (i % 3 == 0)
        System.err.println();
      if (temp.next != null) {
        System.out.print(temp.cell.toString() + " ---> ");
      } else {
        System.out.print(temp.cell.toString() + " ---> X\n\n");
      }
      temp = temp.next;
    }
  }

  /**
   * Linearly traverse the calling CellList and the parameter CellList
   *
   * @param that CellList object to compare
   * @return true or false
   */
  public boolean equals(Object that) {
    if (this == that)
      return true;
    if (that == null || !(that instanceof CellList))
      return false;

    CellList thatCellList = (CellList) that;
    if (this.size != thatCellList.size)
      return false;

    if (this.size == 0)
      return true;

    CellNode temp1 = head;
    CellNode temp2 = thatCellList.head;
    while (temp1 != null && temp2 != null) {
      // ! Usage of ternary operator
      if (temp1.cell == null ? temp2.cell != null : !temp1.cell.equals(temp2.cell)) {
        return false;
      }
      temp1 = temp1.next;
      temp2 = temp2.next;
    }

    return true;
  }

}
