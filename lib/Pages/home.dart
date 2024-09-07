import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Book Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}