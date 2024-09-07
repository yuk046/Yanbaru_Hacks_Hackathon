import 'package:flutter/material.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'School Page',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}