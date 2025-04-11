import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/forms/email_form_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/helpers/debouncer.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/organization_type.dart';
import 'package:notifi/riverpod/enable_widget.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreateOrganizationForm extends ConsumerStatefulWidget {
  const CreateOrganizationForm({super.key});

  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState
    extends ConsumerState<CreateOrganizationForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> nameFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> descriptionFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> urlFormFieldKey = GlobalKey<FormFieldState>();
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

  bool _enableUrl(String url) {
    return (orgTypeIndex != null && orgTypeIndex!.isUrlable);
  }

  bool _validateUrl(String url) {
    if (orgTypeIndex != null && orgTypeIndex!.isUrlable) {
      if (Uri.tryParse(url)!.hasAbsolutePath) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    orgTypeIndex = OrganizationType.GROUP;
    ref.read(enableWidgetProvider("name").notifier).set(true);
    ref.read(enableWidgetProvider("description").notifier).set(true);
    ref.read(enableWidgetProvider("email").notifier).set(true);
     ref.read(enableWidgetProvider("submit").notifier).set(false);
  }

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
      ref.read(enableWidgetProvider("url").notifier).set(value.isUrlable);
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
    var enableSubmit = ref.watch(enableWidgetProvider("submit"));

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
                TextFormFieldWidget(
                  fieldCode: "name",
                  itemCategory: nt.t.organization,
                  itemName: nt.t.name,
                  itemValidation: nt.t.form.name_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex: r"^[\p{L} ,.'-]*$",
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  fieldCode: "description",
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.description(
                    item: nt.t.organization_capitalized,
                  ),
                  itemValidation: nt.t.form.description_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex: r"^[\p{L} ,.'-]*$",
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  fieldCode: "email",
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.email,
                  itemValidation: nt.t.form.email_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex:
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                  forceLowercase: true,
                ),
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
                TextFormFieldWidget(
                  fieldCode: "url",
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.url,
                  itemValidation: nt.t.form.url_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  onValidate: _validateUrl,
                  regex:
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                  forceLowercase: true,
                ),
                // TextFormField(
                //   autovalidateMode: AutovalidateMode.onUnfocus,
                //   enabled: (orgTypeIndex != null && orgTypeIndex!.isUrlable),
                //   controller: _urlController,
                //   autocorrect: true,
                //   decoration: InputDecoration(
                //     labelText: nt.t.form.url,
                //     border: const OutlineInputBorder(),
                //   ),
                //   validator: _validateUrl,
                // ),
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
