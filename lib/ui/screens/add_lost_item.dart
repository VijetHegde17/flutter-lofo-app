import 'package:flutter/material.dart';

class AddLostItemScreen extends StatelessWidget {
  const AddLostItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Lost Item')),
      body: Column(
        children: [
          TextFormField(),
          TextFormField(),
          TextFormField(),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () {}, child: const Text('Submit')),
        ],
      ),
    );
  }
}
