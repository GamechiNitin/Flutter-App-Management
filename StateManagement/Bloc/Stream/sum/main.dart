/* :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 |         To Run open project path in Terminal 
 |         dart run main.dart 
 :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
*/

void main() async {
  Stream<int> stream = countStream(24);

  int val = await sumStream(stream);
  print("Sum of stream is $val");
}

// Sum of Streams of Integers
Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (int value in stream) {
    sum += value;
    print("Stream Count $value : $sum");
  }
  return sum;
}

// Counter Stream
Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}
