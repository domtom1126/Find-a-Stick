import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

enum VehicleType { car, truck }

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  VehicleType? _type = VehicleType.car;
  String truckDropDown = '';
  String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // * Car RadioButton
            RadioListTile<VehicleType>(
              title: const Text('Car'),
              value: VehicleType.car,
              groupValue: _type,
              onChanged: (VehicleType? value) {
                setState(() {
                  _type = value;
                });
              },
            ), // Todo make radio buttons inline
            // * Truck RadioButton
            RadioListTile<VehicleType>(
              title: const Text('Truck'),
              value: VehicleType.truck,
              groupValue: _type,
              onChanged: (VehicleType? value) {
                setState(() {
                  _type = value;
                });
              },
            ),
            // * Make Dropdown
            DropdownButtonFormField<String>(
                hint: Text('Choose Make'),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            // * Model Dropdown
            DropdownButtonFormField<String>(
                hint: Text('Choose Model'),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Escort', 'Corolla', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Miles'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            // showDatePicker(context: context, initialDatePickerMode: DatePickerMode.year , firstDate: DateTime(), lastDate: lastDate)
            // TextFormField()
            // Todo onPressed needs to post to carList db
            ElevatedButton(onPressed: null, child: Text('Post car'))
          ],
        ),
      ),
    );
  }
}
