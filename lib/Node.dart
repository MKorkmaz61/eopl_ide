import 'dart:core';

class Node<E> {
  late E data;
  List<Node<E>> children = List.empty(growable: true);
  String tag = "";

  /// Convenience ctor to create a Node<T> with an instance of T.
  /// @param data an instance of T.

  Node(E data) {
    setData(data);
  }

  /// Return the children of Node<T>. The Tree<T> is represented by a single
  /// root Node<T> whose children are represented by a List<Node<T>>. Each of
  /// these Node<T> elements in the List can have children. The getChildren()
  /// method will return the children of a Node<T>.
  /// @return the children of Node<T>
  List<Node<E>> getChildren() {
    return this.children;
  }

  /// Sets the children of a Node<T> object. See docs for getChildren() for
  /// more information.
  /// @param children the List<Node<T>> to set.
  void setChildren(List<Node<E>> children) {
    this.children = children;
  }

  /// Returns the number of immediate children of this Node<T>.
  /// @return the number of immediate children.
  int getNumberOfChildren() {
    if (children == null) {
      return 0;
    }
    return children.length;
  }

  /// Adds a child to the list of children for this Node<T>. The addition of
  /// the first child will create a new List<Node<T>>.
  /// @param child a Node<T> object to set.
  void addChild(Node<E> child) {
    children ??= List<Node<E>>.empty();
    children.add(child);
  }

  /// Inserts a Node<T> at the specified position in the child list. Will     * throw an ArrayIndexOutOfBoundsException if the index does not exist.
  /// @param index the position to insert at.
  /// @param child the Node<T> object to insert.
  /// @throws IndexOutOfBoundsException if thrown.
  void insertChildAt(int index, Node<E> child) {
    if (index == getNumberOfChildren()) {
      // this is really an append
      addChild(child);
      return;
    } else {
      children.elementAt(index); //just to throw the exception, and stop here
      children.insert(index, child);
    }
  }

  /// Remove the Node<T> element at index index of the List<Node<T>>.
  /// @param index the index of the element to delete.
  /// @throws IndexOutOfBoundsException if thrown.
  void removeChildAt(int index) {
    children.removeAt(index);
  }

  E getData() {
    return this.data;
  }

  void setData(E data) {
    this.data = data;
  }

  void setTag(String tag) {
    this.tag = tag;
  }

  String getTag() {
    return tag;
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write("{");
    sb.write(getData().toString());
    sb.write("\n[");
    int i = 0;
    for (Node<E> e in getChildren()) {
      if (i > 0) {
        sb.write(",");
      }
      sb.write(e.toString());
      i++;
    }
    sb.write("]\n");
    sb.write("}");
    return sb.toString();
  }
}
