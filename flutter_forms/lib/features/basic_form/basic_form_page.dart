import 'package:flutter/material.dart';

class BasicFormPage extends StatefulWidget {
  const BasicFormPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const BasicFormPage(),
      ),
    );
  }

  @override
  _BasicFormPageState createState() => _BasicFormPageState();
}

class _BasicFormPageState extends State<BasicFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Form'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40.0),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container();
  }
}
