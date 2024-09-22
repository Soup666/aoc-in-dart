import 'dart:io';
import 'dart:core';

void main() async {
  final File file = File('input.txt');
  final List<String> lines = await file.readAsLines();

  List<List<String>> matrix = [];

  for (var line in lines) {
    matrix.add(line.split(''));
  }

  List<String> parts = [];

  int currentX = 0;
  int currentY = 0;

  while (currentY < lines.length) {
    while (true) {
      while (lines[currentY][currentX] == '.' &&
          currentX < lines[currentY].length - 1) currentX++;

      if (currentX > lines[currentY].length - 1) break;

      int endOfBlock = currentX;
      while (endOfBlock < lines[currentY].length &&
          lines[currentY][endOfBlock] != '.' &&
          lines[currentY][endOfBlock].codeUnits.first >= 48 &&
          lines[currentY][endOfBlock].codeUnits.first <= 57) endOfBlock++;

      String currentBlock = lines[currentY].substring(currentX, endOfBlock);

      List<String> block = [];

      for (int x = -1; x < currentBlock.length + 1; x++) {
        int tempX = currentX + x;
        int tempY = currentY - 1;
        bool outOfBounds = tempY < 0 ||
            tempY >= lines.length ||
            tempX < 0 ||
            tempX >= lines[tempY].length;
        block.add(outOfBounds ? '.' : matrix[tempY][tempX]);
      }

      block.add(
          currentX - 1 < 0 ? '.' : matrix[currentY][currentX - 1]); // left item
      block.add((currentX + currentBlock.length) > lines[currentY].length - 1
          ? '.'
          : lines[currentY][currentX + currentBlock.length]); // right item

      for (int x = -1; x < currentBlock.length + 1; x++) {
        int tempX = currentX + x;
        int tempY = currentY + 1;
        bool outOfBounds = tempY < 0 ||
            tempY >= lines.length ||
            tempX < 0 ||
            tempX >= lines[tempY].length;
        block.add(outOfBounds ? '.' : matrix[tempY][tempX]);
      }

      // Check for symbols
      bool skippable = block.any((c) =>
              c != '.' ||
              (c.codeUnits.first >= 48 && c.codeUnits.first <= 57)) &&
          block.isNotEmpty;

      if (currentBlock.isNotEmpty)
        print("${skippable ? '  Found' : 'Missed'}: $currentBlock ($block)");

      if (skippable && currentBlock.isNotEmpty) {
        parts.add(currentBlock);
      }

      currentX =
          currentX + ((currentBlock.length) == 0 ? 1 : currentBlock.length);
      if (currentX > lines[currentY].length - 1) break;
    }
    currentX = 0;
    currentY++;
  }

  // filter out symbols
  int total = parts.fold(
      0, (previousValue, element) => previousValue + int.parse(element));

  print("Total: $total ($parts)");
}
