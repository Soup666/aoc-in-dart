import 'dart:async';
import 'dart:io';

final List<String> words = [
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];

void main() async {
  final Stopwatch stopwatch = Stopwatch()..start();

  final File input = File('input.txt');
  final List<String> content = (await input.readAsString()).split('\n');
  final List<int> values = content.map((e) {
    if (e.isEmpty) return 0;
    int f1 = 0;
    int f2 = e.length - 1;
    
    int? value1 = null;
    int? value2 = null;

    while (value1 == null || value2 == null) {
      // Check word first

      if (value1 == null) {
        for (int i = 0; i < words.length; i++) {
          if (e.substring(f1).startsWith(words[i])) {
            value1 = i + 1;
            f1 += words[i].length;
            break;
          }
        }
      }

      if (value2 == null) {
        for (int i = 0; i < words.length; i++) {
          if (e.substring(0, f2 + 1).endsWith(words[i])) {
            value2 = i + 1;
            f2 -= words[i].length;
            break;
          }
        }
      }

      // Check digits
  
      if (value1 == null) {
        value1 = int.tryParse(e[f1]);
        f1++;
      }

      if (value2 == null) {
        value2 = int.tryParse(e[f2]);
        f2--;
      }
    }

    if (value1 == null || value2 == null) {
      throw Exception('Invalid input for $e $f1 $f2 $value1 $value2');
    }
 
    return int.parse("$value1$value2");
  }).toList();

  final sum = values.fold(0, (a, b) => a + b);

  stopwatch.stop();
  print("Found answer: $sum in ${stopwatch.elapsedMilliseconds}ms");
}

