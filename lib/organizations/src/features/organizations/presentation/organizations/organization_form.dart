
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart' as emailValidator;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/submit_button_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/organization_type.dart';
import 'package:notifi/riverpod/enable_widget.dart';
import 'package:notifi/riverpod/refresh_widget.dart';
import 'package:notifi/state/nest_auth2.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreateOrganizationForm extends ConsumerStatefulWidget {
  CreateOrganizationForm({super.key,required this.formCode});

String formCode;

  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState
    extends ConsumerState<CreateOrganizationForm> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _urlController = TextEditingController();

  OrganizationType? orgTypeIndex;


  bool _validateEmail(String? email) {
    if (email == null) {
      return false;
    }
    return emailValidator.EmailValidator.validate(email);
  }

  @override
  void initState() {
    super.initState();
    orgTypeIndex = OrganizationType.GROUP;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChanged(OrganizationType? value) {
    if (value != null) {
      setState(() {
        orgTypeIndex = value;
        logNoStack.i(orgTypeIndex!.name);
      });
      ref
          .read(enableWidgetProvider("false-url").notifier)
          .setEnabled(value.isUrlable);
    }
  }

  // void _handleSubmit() {
  //   // Submit the form data
  //   final organizationData = {
  //     'name': _nameController.text,
  //     'description': _descriptionController.text,
  //     'email': _emailController.text,
  //     'url': _urlController.text,
  //     'orgType': orgTypeIndex!.name,
  //     //   'phone': _phoneController.text,
  //     //   'address': _addressController.text,
  //   };
  //   // Call API or perform action to create organization
  //   print(organizationData);
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(refreshWidgetProvider("organization"));
    String capitalizedItem = nt.t.organization_capitalized;
    logNoStack.i("Organization form build $watch");
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  textController: _nameController,
                   formKey: _formKey,
                  formCode: widget.formCode,
                  fieldCode: "true-name",
                  itemCategory: nt.t.organization,
                  itemName: nt.t.name,
                  itemValidation: nt.t.form.name_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex: r"^[\p{L} ,.'-0-9]*$",
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  textController: _descriptionController,
                   formKey: _formKey,
                  formCode: widget.formCode,
                  fieldCode: "true-description",
                  enabled: true,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.description(
                    item: nt.t.organization_capitalized,
                  ),
                  itemValidation: nt.t.form.description_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex: r"^[\p{L} ,.'-0-9]*$",
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  textController: _emailController,
                   formKey: _formKey,
                   formCode: widget.formCode,
                  fieldCode: "true-email",
                  enabled: true,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.email,
                  itemValidation: nt.t.form.email_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  onValidate: _validateEmail,
                  regex:
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                  forceLowercase: true,
                ),
                const SizedBox(height: 16),

                RadioListTile<OrganizationType>(
                  key: const Key("group"),
                  dense: true,
                  title: Text(nt.t.group_types.group),
                  value: OrganizationType.GROUP,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("family"),
                  dense: true,
                  title: Text(nt.t.group_types.family),
                  value: OrganizationType.FAMILY,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("friends"),
                  dense: true,
                  title: Text(nt.t.group_types.friends),
                  value: OrganizationType.FRIENDS,
                  // selected: OrganizationType.FRIENDS==orgTypeIndex,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("org"),
                  dense: true,
                  title: Text(nt.t.group_types.org),
                  value: OrganizationType.ORG,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile<OrganizationType>(
                  key: const Key("government"),
                  dense: true,
                  title: Text(nt.t.group_types.government),
                  value: OrganizationType.GOVERNMENT,
                  groupValue: orgTypeIndex,
                  onChanged: _handleRadioValueChanged,
                ),

                const SizedBox(height: 16),
                TextFormFieldWidget(
                  textController: _urlController,
                  formKey: _formKey,
                   formCode: widget.formCode,
                  fieldCode: "false-url",
                  enabled: false,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.url,
                  itemValidation: nt.t.form.url_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex:
                      r"^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$",
                  optional: true,
                  forceLowercase: true,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   CancelButtonWidget(formKey: _formKey, formCode: widget.formCode),
                    const SizedBox(width: 16),
                  //SubmitButtonWidget(formKey: _formKey, formCode: widget.formCode)
                    Consumer(
                     builder: (context, watch, child) {
                  var enableStr = watch.watch(refreshWidgetProvider("${widget.formCode}-submit"));
                     logNoStack.i("Organization Submit button $enableStr ");
                      return 
                  ElevatedButton(
                       key: const Key("organization-submit"),
                        onPressed: () {
                        //(!enableStr.startsWith("true"))? null : () {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                         if (_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(nt.t.saving),
                            ),
                          );

                            // save organization
                            Organization organization = Organization(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              orgType: orgTypeIndex!.name,
                              url: _urlController.text,
                              email: _emailController.text,
                              );
                                var token = ref.read(nestAuthProvider.notifier).token;
                                var apiPath = "$defaultAPIBaseUrl$defaultApiPrefixPath/organizations";
                                 var result = apiPostDataNoLocaleRaw(token!, apiPath, organization);  

  logNoStack.i("result is ${result}");
                          Navigator.of(context).pop();
                        }},
                          // !(_formKey.currentState != null &&
                          //         _formKey.currentState!.validate())
                          //     ? null
                          //     : () {
                          //       //   ScaffoldMessenger.of(context).showSnackBar(
                          //       //    SnackBar(
                          //       //     content: Text(nt.t.saving),
                          //       //   ),
                          //       // );
                          //       Navigator.of(context).pop();
                           //   },

                        child: Text(nt.t.response.submit),
                      );
                     },
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
