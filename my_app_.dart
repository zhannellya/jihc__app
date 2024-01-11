import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page/pages/screen_page.dart';
import 'package:page/pages/teachers_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo page',
      initialRoute: '/',
      routes: {
        '/teachers_page': (context) => TeachersPage(),
        '/screen_page': (context) => ScreenPage(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _photolinkController = TextEditingController();

  List<Map<String, dynamic>> _items = [];
  final _shoppingBox = Hive.box('shopping_box');

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  @override
  void dispose() {
    _nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _refreshItems() {
    final data = _shoppingBox.keys.map((key) {
      final item = _shoppingBox.get(key);
      return {
        "key": key,
        "name": item["name"],
        "quantity": item['quantity'],
        "photolink": item['photolink'],
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _shoppingBox.add(newItem);
    _refreshItems();
  }

  Future<void> _deleteItem(int itemKey) async {
    await _shoppingBox.delete(itemKey);
    _refreshItems();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Quantity'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _photolinkController,
                    decoration: const InputDecoration(hintText: 'Photolink'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _createItem({
                        "name": _nameController.text,
                        "quantity": _quantityController.text,
                        "photolink": _photolinkController.text,
                      });

                      _nameController.text = '';
                      _quantityController.text = '';
                      _photolinkController.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text('Create New'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ));
  }

  List<Map<String, dynamic>> _foundUsers = [
    {
      "photo": "assets/it.jpeg",
      "name": "11 teachers",
      "lesson": "IT",
      'url':
          'https://podcasts.google.com/feed/aHR0cHM6Ly9yc3MuY2FzdGJveC5mbS9ldmVyZXN0L2Y1NDAzMzZkMmE4YTRlNTRiY2IyZGM1ZmYxNmE1NzM1LnhtbA/episode/YWxidW0tZjU0MDMzNmQyYThhNGU1NGJjYjJkYzVmZjE2YTU3MzUtYWM5MWNiN2Y4ZTEwNGEyYTg3OTFhMzMzZmU4NjZlMWQ?sa=X&ved=0CAUQkfYCahcKEwjYmYiIp8WDAxUAAAAAHQAAAAAQLA',
    },
    {
      "photo": "assets/audit.jpg",
      "name": "10 teachers",
      "lesson": "Audit",
      'url':
          'https://podcasts.google.com/feed/aHR0cHM6Ly9yc3MuY2FzdGJveC5mbS9ldmVyZXN0L2Y1NDAzMzZkMmE4YTRlNTRiY2IyZGM1ZmYxNmE1NzM1LnhtbA/episode/YWxidW0tZjU0MDMzNmQyYThhNGU1NGJjYjJkYzVmZjE2YTU3MzUtYWM5MWNiN2Y4ZTEwNGEyYTg3OTFhMzMzZmU4NjZlMWQ?sa=X&ved=0CAUQkfYCahcKEwjYmYiIp8WDAxUAAAAAHQAAAAAQLA',
    },
    {
      "photo": "assets/all.jpg",
      "name": "21 teachers",
      "lesson": "All",
      'url':
          'https://podcasts.google.com/feed/aHR0cHM6Ly9yc3MuY2FzdGJveC5mbS9ldmVyZXN0L2Y1NDAzMzZkMmE4YTRlNTRiY2IyZGM1ZmYxNmE1NzM1LnhtbA/episode/YWxidW0tZjU0MDMzNmQyYThhNGU1NGJjYjJkYzVmZjE2YTU3MzUtYWM5MWNiN2Y4ZTEwNGEyYTg3OTFhMzMzZmU4NjZlMWQ?sa=X&ved=0CAUQkfYCahcKEwjYmYiIp8WDAxUAAAAAHQAAAAAQLA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jihc App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: _buildGridView(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final currentItem = _items[index];
        return Container(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                elevation: 4,
                margin: const EdgeInsets.all(15),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 220,
                        width: 130,
                        child: Image.network(currentItem['photolink']),
                      ),
                      _textBuildCustom(index, context),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            _widgetButton('It'),
                            _widgetButton('Audit'),
                            _widgetButton('All'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _widgetButton(String text) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/teachers_page',
          arguments: text,
        );
      },
      child: _textBuildCustomer(text),
    );
  }

  Widget _textBuildCustom(index, context) {
    final currentItem = _items[index];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentItem['name'],
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen_page',
                      arguments: _foundUsers[index]);
                },
                icon: const Icon(
                  Icons.home_rounded,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              Text(
                currentItem['quantity'],
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteItem(currentItem['key'])),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/screen_page',
              //         arguments: _foundUsers[index]);
              //   },
              //   child: Text(
              //     _foundUsers[index]["lesson"].toString(),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _textBuildCustomer(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
