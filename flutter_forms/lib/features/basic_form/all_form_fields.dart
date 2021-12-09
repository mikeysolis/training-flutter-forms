import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// TODO: Add a dropdown, checkbox, phone number input,
// credit card input and maybe a datetime input.

class AllFormFields extends StatefulWidget {
  const AllFormFields({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const AllFormFields(),
      ),
    );
  }

  @override
  _AllFormFieldsState createState() => _AllFormFieldsState();
}

class _AllFormFieldsState extends State<AllFormFields> {
  // Let's setup everything we need for the form

  // 1) First we need to create a GlobalKey so the form may be uniquely
  // identified for validation.
  final _formKey = GlobalKey<FormState>();

  // 2) Second create the controllers for the input field. We need these
  // to actually access the data from the fields.
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final commentsInputController = TextEditingController();

  // 3) Third, create any validators for the form fields. In this example
  // I will use the form_field_validator package. To see an example of validation
  // using native Flutter view the 'Basic Form' example.
  final nameValidator = RequiredValidator(errorText: 'Please enter your name');
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter your email'),
    EmailValidator(errorText: 'Please enter a valid email'),
  ]);

  // 4) Fourth we need a submit method for the form. I'm putting this here so
  // our form code below doesn't get to messy.
  void _submit(BuildContext context) {
    // Here we are using the _formKey to check if the form has
    // passed validation. If it has this will pass as true, else false.
    if (_formKey.currentState!.validate()) {
      // Showing the user a snackbar to let them know the form is being processed.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submitting form data'),
        ),
      );

      // Usually we would send the form data to a database somewhere but in
      // this case we are just creating an alert dialog to show the user
      // the data. In this case we are using a package called rflutter_alert
      // to easily create the alert.
      _showAlert(context);
    }
  }

  // 5) Let's be sure to dispose of the TextEditingControllers
  // so we don't have any memory leaks.
  @override
  void dispose() {
    nameInputController.dispose();
    emailInputController.dispose();
    commentsInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Form')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              const Text(
                "Form built with only Flutter native form inputs. The goal is simply to show them all.",
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 40.0),
              _buildForm(context),
            ],
          ),
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
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Text Fields',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: nameInputController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Name*',
              hintText: 'Enter your name',
            ),
            // This is the validator we created above using the
            // form_field_validator package.
            validator: nameValidator,
          ),
          TextFormField(
            controller: emailInputController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email*',
              hintText: 'Enter your email',
            ),
            validator: emailValidator,
          ),
          const SizedBox(height: 40.0),
          const Text(
            'Textarea',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          // A textarea is just a TextFormField with a couple small changes.
          // Added the parameter 'maxLines' and the InputDecoration is .collapsed.
          // I also added it inside of a Card widget just to add a background color
          // which makes it easier for the user to see the entire textarea.
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: commentsInputController,
                maxLines: 8,
                // the .collapsed version of input decoration removes the inputs
                // label and the bottom border.
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter any comments',
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () => _submit(context),
          ),
        ],
      ),
    );
  }

  // Method to show an alert to the user displaying the data submitted
  // with the form. Not super important to us as far as the form is
  // concerned so putting it way down here.
  void _showAlert(BuildContext context) {
    // Styling the alert
    final alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      animationDuration: const Duration(milliseconds: 400),
      titleStyle: const TextStyle(fontSize: 16.0),
      titleTextAlign: TextAlign.start,
      descStyle: const TextStyle(fontSize: 12.0),
      descTextAlign: TextAlign.start,
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    );

    Future.delayed(
      const Duration(seconds: 2),
      () => Alert(
        context: context,
        type: AlertType.none,
        style: alertStyle,
        title: 'Submitted Form Data',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              'Name: ${nameInputController.text}',
              style: const TextStyle(fontSize: 12.0, height: 1.5),
            ),
            Text(
              'Email: ${emailInputController.text}',
              style: const TextStyle(fontSize: 12.0, height: 1.5),
            ),
            Text(
              'Comments: ${commentsInputController.text.isNotEmpty ? commentsInputController.text : 'No comments'}',
              style: const TextStyle(fontSize: 12.0, height: 1.5),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ).show(),
    );
  }
}
