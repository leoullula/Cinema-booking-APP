import 'package:flutter/material.dart';

void main() => runApp(const MyApppay());

class MyApppay extends StatelessWidget {
  const MyApppay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue[500],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 300,
      width: 300,
      child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Form",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue),
                      ),
                      Icon(
                        Icons.credit_card,
                        color: Colors.blue,
                      )
                    ]),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Card Number',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Ticket Amount',
                  ),
                  // The validat
                  //or receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
