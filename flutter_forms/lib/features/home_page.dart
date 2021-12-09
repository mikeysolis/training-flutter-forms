// Class: HomePage
// This class display a basic form using only the Flutter SDK,
// no plugins or anything else.

import 'package:flutter/material.dart';

import 'basic_form/basic_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Projects'),
      ),
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: const Text('Basic Form'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => BasicFormPage.show(context),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
