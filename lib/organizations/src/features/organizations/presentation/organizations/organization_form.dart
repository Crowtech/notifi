import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreateOrganizationForm extends StatefulWidget {
  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState extends State<CreateOrganizationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nt.t.organization.create,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: nt.t.organization.name,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return nt.t.organization.name_validation;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                expands: true,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: nt.t.organization.description,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return nt.t.organization.description_validation;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: nt.t.organization.email,
                  border: OutlineInputBorder(),
                ),
  validator: (input) => EmailValidator.validate(input!)? null : nt.t.organization.email_validation,
              ),
              // SizedBox(height: 16),
              // TextFormField(
              //   controller: _phoneController,
              //   decoration: InputDecoration(
              //     labelText: 'Organization Phone Number',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter organization phone number';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16),
              // TextFormField(
              //   controller: _addressController,
              //   decoration: InputDecoration(
              //     labelText: 'Organization Address',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter organization address';
              //     }
              //     return null;
              //   },
              //),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(nt.t.response.cancel),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit the form data
                        final organizationData = {
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                          'email': _emailController.text,
                       //   'phone': _phoneController.text,
                       //   'address': _addressController.text,
                        };
                        // Call API or perform action to create organization
                        print(organizationData);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(nt.t.response.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}