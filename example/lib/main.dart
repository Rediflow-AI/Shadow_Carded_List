import 'package:flutter/material.dart';
import 'package:shadowed_carded_list/shadowed_carded_list.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CardedList Example',
      theme: ThemeData.light(),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final List<String> _items = [];
  int _counter = 0;

  void _addItem() {
    setState(() {
      _items.insert(0, 'Item ${++_counter}');
    });
  }

  void _clearItems() {
    setState(() {
      _items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CardedList Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: CardedList<String>(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add),
                          tooltip: 'Add item',
                        ),
                        IconButton(
                          onPressed: _clearItems,
                          icon: const Icon(Icons.clear_all),
                          tooltip: 'Clear items',
                        ),
                      ],
                    ),
                  ],
                ),
                footer: Text('${_items.length} item(s)'),
                items: _items,
                emptyListMessage: 'No items yet. Tap + to add one.',
                itemBuilder: (context, index) {
                  final text = _items[index];
                  return ListTile(
                    key: ValueKey(text),
                    title: Text(text),
                    leading: const CircleAvatar(child: Icon(Icons.list)),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text('Demo controls: add / clear inside the header buttons'),
          ],
        ),
      ),
    );
  }
}
