import 'package:flutter/material.dart';

extension ToListview<T> on Iterable<T> {
  Widget toListView() => IterableListview(iterable: this);
}

class IterableListview<T> extends StatelessWidget {
  final Iterable<T> iterable;
  const IterableListview({super.key, required this.iterable});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            iterable.elementAt(index).toString(),
          ),
        );
      },
    );
  }
}
