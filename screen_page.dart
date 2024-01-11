import 'package:flutter/material.dart';

class ScreenPage extends StatelessWidget {
  ScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _foundUsers =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(_foundUsers['name'])),
      body: myItem(context, _foundUsers),
    );
  }

  Widget myItem(BuildContext context, Map<String, dynamic> _foundUsers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              width: 250,
              height: 300,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _textBuildCustomer(context, _foundUsers)),
        ),
      ],
    );
  }

  Widget _textBuildCustomer(
      BuildContext context, Map<String, dynamic> _foundUsers) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        image: DecorationImage(
          image: AssetImage(_foundUsers['photo']),
          fit: BoxFit.cover,
        ),
      ),
      child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.how_to_reg,
                  size: 21,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Bakytzhan Kazangapov',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You can see information about teacher',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
