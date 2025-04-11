import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:notifi/forms/email_form_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/organization_type.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreateOrganizationForm extends StatefulWidget {
  const CreateOrganizationForm({super.key});

  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState extends State<CreateOrganizationForm> {
  final _formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState> nameFormFieldKey =
      GlobalKey<FormFieldState>();
        final GlobalKey<FormFieldState> descriptionFormFieldKey =

      GlobalKey<FormFieldState>();
        final GlobalKey<FormFieldState> urlFormFieldKey =
      GlobalKey<FormFieldState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _urlController = TextEditingController();
  final _addressController = TextEditingController();

  String? _olderNameValue;
  String? _olderDescriptionValue;
  String? _olderUrlValue;

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  OrganizationType? orgTypeIndex;

  @override
  void dispose() {
    _debouncer.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _urlController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleRadioValueChanged(OrganizationType? value) {
    if (value != null) {
      setState(() {
        orgTypeIndex = value;
        print(orgTypeIndex!.name);
      });
    }
  }

  void _handleSubmit() {
    // Submit the form data
    final organizationData = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'email': _emailController.text,
      'url': _urlController.text,
      'orgType': orgTypeIndex!.name,
      //   'phone': _phoneController.text,
      //   'address': _addressController.text,
    };
    // Call API or perform action to create organization
    print(organizationData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedItem = nt.t.organization_capitalized;


    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nt.t.form.create(item: capitalizedItem),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(itemCategory: nt.t.organization, itemName:nt.t.name, itemValidation: nt.t.form.name_validation(item: nt.t.organization_capitalized), regex: r"^[\p{L} ,.'-]*$"),
                const SizedBox(height: 16),
                  TextFormFieldWidget(itemCategory: nt.t.organization, itemName: nt.t.form.description(item: nt.t.organization_capitalized), itemValidation: nt.t.form.description_validation(item: nt.t.organization_capitalized), regex: r"^[\p{L} ,.'-]*$"),
                const SizedBox(height: 16),
                EmailTextFormFieldWidget(itemCategory: capitalizedItem),
                const SizedBox(height: 16),

                RadioListTile<OrganizationType>(
                  key: const Key("group"),
                  title: Text(nt.t.group_types.group),
                  value: OrganizationType.GROUP,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("family"),
                  title: Text(nt.t.group_types.family),
                  value: OrganizationType.FAMILY,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("friends"),
                  title: Text(nt.t.group_types.friends),
                  value: OrganizationType.FRIENDS,
                  // selected: OrganizationType.FRIENDS==orgTypeIndex,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("ord"),
                  title: Text(nt.t.group_types.org),
                  value: OrganizationType.ORG,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("government"),
                  title: Text(nt.t.group_types.government),
                  value: OrganizationType.GOVERNMENT,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),

                const SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  enabled: (orgTypeIndex != null && orgTypeIndex!.isUrlable),
                  controller: _urlController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: nt.t.form.url,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (orgTypeIndex != null && !orgTypeIndex!.isUrlable) {
                      _urlController.value = TextEditingValue.empty;
                      return null;
                    } else if (value != null &&
                        value.isUri() &&
                        orgTypeIndex!.isUrlable) {
                      return null; // good
                    } else {
                      return nt.t.form.url_validation(item: capitalizedItem);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(nt.t.response.cancel),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed:
                          (_formKey.currentState != null &&
                                  _formKey.currentState!.validate())
                              ? _handleSubmit
                              : null,
                      child: Text(nt.t.response.submit),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
