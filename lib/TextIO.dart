class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  int get length => _list.length;

  @override
  String toString() => _list.toString();
}

class TextIO {
  static Stack<String> bufferStack = Stack<String>();
  static String? buffer;
  static int pos = 0;

  static String getBuffer() {
    return buffer!;
  }

  static void setBuffer(String buffer) {
    TextIO.buffer = buffer;
  }

  static int getPos() {
    return pos;
  }

  static void setPos(int pos) {
    TextIO.pos = pos;
  }

  static void rewind(int rew) {
    TextIO.pos -= rew;
  }

  static void fillBuffer(String buffer, int p) {
    TextIO.setBuffer(buffer + "\n" + "\n" + " " + '~');
    TextIO.setPos(p);
  }

  static String lookChar() {
    if (buffer == null || pos > buffer!.length) return '\r';
    if (pos == buffer!.length) return '\n';
    return String.fromCharCode(buffer!.codeUnitAt(pos));
  }

  static String getWord() {
    String ch = lookChar();
    while (ch == ' ' || ch == '\n' || ch == '\t') {
      readChar();

      ch = lookChar();
    }
    StringBuffer str = StringBuffer();
    while (ch != ')' &&
        ch != ' ' &&
        ch != '\n' &&
        ch != '(' &&
        ch != '"' &&
        ch != '\'' &&
        ch != '`' &&
        ch != '{' &&
        ch != '}' &&
        ch != '[' &&
        ch != ']' &&
        ch != ';' &&
        ch != '|' &&
        ch != ',') {
      str.write(readChar());
      ch = lookChar();
    }

    return str.toString();
  }

  static String peekWord() {
    String temp = getWord();
    pos = pos - temp.length;
    return temp;
  }

  static String readChar() {
    // return and discard next character from input
    String ch = lookChar();
    pos++;
    return ch;
  }

  /// One must sure that the next character in the buffer string is '(' before calling this function.
  static String getBetweenParentheses() {
    String nc = getChar();
    int oldPos = TextIO.getPos() - 1;

    if (nc == '(') {
      int numPara = 1;

      while (numPara != 0 && TextIO.moreInput()) {
        nc = readChar();
        if (nc == '(') {
          numPara++;
        } else if (nc == ')') {
          numPara--;
        }
      }

      if (numPara == 0) {
        return TextIO.getBuffer().substring(oldPos, TextIO.getPos());
      }
    }

    return "";
  }

  static void skipBlanks() {
    // Skip past any spaces and tabs on the current line of input.
    // Stop at a non-blank character or end-of-line.

    while (TextIO.peek() == ' ' ||
        TextIO.peek() == '\t' ||
        TextIO.peek() == '\n' ||
        TextIO.peek() == '\r') {
      TextIO.readChar();
    }
  }

  static String peek() {
    return lookChar();
  }

  static String getChar() {
    // skip spaces & cr's, then return next char
    String ch = lookChar();

    while (ch == ' ' || ch == '\n') {
      readChar();
      ch = lookChar();
    }

    return readChar();
  }

  static bool moreInput() {
    TextIO.skipBlanks();
    return (TextIO.peek() != '~'); //(TextIO.pos < (TextIO.buffer.length()));
  }

  static isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

  static int getInt() {
    return readInteger();
  }

  static int readInteger() {
    int x = 0;
    StringBuffer s = StringBuffer();
    while (true) {
      String c = lookChar();
      if (isDigit(c, 0)) {
        s.write(readChar());
      } else {
        break;
      }
    }

    x = int.parse(s.toString());
    return x;
  }

  /// Pushes the current buffer into stack and fills the buffer with given string and position
  /// @param para
  /// @param i
  static void pushBufferAndFillWith(String para, int i) {
    bufferStack.push(buffer!);
    bufferStack.push(pos.toString());

    fillBuffer(para, i);
  }

  /// Pops the topmost buffer from the stack and fills the buffer with it.
  static void popBufferAndFill() {
    String pos = bufferStack.pop();
    String buffer = bufferStack.pop();

    fillBuffer(buffer, int.parse(pos));
  }
}
