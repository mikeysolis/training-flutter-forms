// Class: BasicFormPage
// This page display a form using only the native Flutter SDK.
// No database implementation, bloc pattern or anything else is
// included. Those will be built separately.

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class BasicFormPage extends StatefulWidget {
  const BasicFormPage({Key? key}) : super(key: key);

  // Method: show
  // Static method allows the page to call itself from other pages.
  // Simplifies calling the page widget.
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

// Build the page widget, all the content except the form.
//The form is separated out into it's own method below.
class _BasicFormPageState extends State<BasicFormPage> {
  // Let's setup everything we need for the form

  // 1) First we need to create a GlobalKey so the form may be uniquely
  // identified for validation.
  final _formKey = GlobalKey<FormState>();

  // 2) Second create the controllers for the input field. We need these
  // to actually access the data from the fields.
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();

  // 3) Thid create the validator for the email input field using
  // the form_field_validator package.
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your email'),
    EmailValidator(errorText: 'Not a valid email'),
  ]);

  // 4) Fourth we need a submit method for the form. I'm putting this here so
  // our form code below doesn't get to messy.
  void _submit() {
    // Here we are using the _formKey to check if the form has
    // passed validation. If it has this will pass as true, else false.
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Name: ${nameInputController.text}\nEmail: ${emailInputController.text}'),
        ),
      );
    }
  }

  // 5) Let's be sure to dispose of the TextEditingControllers
  // so we don't have any memory leaks.
  @override
  void dispose() {
    nameInputController.dispose();
    emailInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            const Text(
              "This basic form uses only the Flutter SDK. There are packages that make forms easier to implement but it's good to know how it works underneath",
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 40.0),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  // Method: _buildForm
  // This methods is where the actual form is built.
  Widget _buildForm(BuildContext context) {
    // Create the Form widget. All text input widgets must be inside
    // the Form widget for validation and such to happen.
    return Form(
      key: _formKey, // add the GlobalKey we made above
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          TextFormField(
            controller: nameInputController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name*',
            ),
            // This is how validation is done using the built in way.
            // Lot's of great packages exists so we don't have to recreate
            // the wheel. We use one below for the email field.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: emailInputController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your email',
              labelText: 'Email*',
            ),
            // Email validation isn't build in so in this case I'm breaking
            // the no package rule and downloading form_field_validator which
            // easily handle all kinds of validation for us.
            validator: emailValidator,
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
