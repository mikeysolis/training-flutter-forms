// Class: HomePage
// This class just displays a ListView of different forms that
// have been built. These forms include:
// 1) Flutter Form - a basic form using only the Flutter SDK
// 2) Reactive Form - the same form as above but implented using the reactive_forms package.

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
              title: const Text('Flutter Form'),
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
