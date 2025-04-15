import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:logger/logger.dart' as logger;
import 'package:notifi/models/organization_type.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreateOrganizationForm3 extends ConsumerStatefulWidget {
  CreateOrganizationForm3({super.key, required this.formCode});

  String formCode;

  @override
  _CreateOrganizationForm3State createState() =>
      _CreateOrganizationForm3State();
}

class _CreateOrganizationForm3State
    extends ConsumerState<CreateOrganizationForm3> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _nameHasError = false;
  bool _genderHasError = false;

  var orgTypeOptions = [
    OrganizationType.DEFAULT,
    OrganizationType.FAMILY,
    OrganizationType.FRIENDS,
    OrganizationType.EDUCATION,
    OrganizationType.GROUP,
    OrganizationType.ORG,
    OrganizationType.TEAM,
    OrganizationType.DEPARTMENT,
    OrganizationType.COMPANY,
    OrganizationType.COMMERCIAL,
    OrganizationType.GOVERNMENT,
    OrganizationType.PRIVATE,
    OrganizationType.PERSON,
    OrganizationType.UNKNOWN
  ];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: const {
                  'orgType': 'group',
                  'best_language': 'Dart',
                  'age': '13',
                  'gender': 'Male',
                  'languages_filter': ['Dart']
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),

                    // FormBuilderCheckbox(
                    //   name: 'accept_terms',
                    //   initialValue: false,
                    //   onChanged: _onChanged,
                    //   title: RichText(
                    //     text: const TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: 'I have read and agree to the ',
                    //           style: TextStyle(color: Colors.black),
                    //         ),
                    //         TextSpan(
                    //           text: 'Terms and Conditions',
                    //           style: TextStyle(color: Colors.blue),
                    //           // Flutter doesn't allow a button inside a button
                    //           // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                    //           /*
                    //       recognizer: TapGestureRecognizer()
                    //         ..onTap = () {
                    //           print('launch url');
                    //         },
                    //       */
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   validator: FormBuilderValidators.equal(
                    //     true,
                    //     errorText:
                    //         'You must accept terms and conditions to continue',
                    //   ),
                    // ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: nt.t.name,
                        suffixIcon: _nameHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _nameHasError = !(_formKey
                                  .currentState?.fields['name']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.singleLine(),
                        FormBuilderValidators.match(RegExp(
                          r"^[\p{L} ,.'-0-9]*$",
                          caseSensitive: false,
                          unicode: true,
                          dotAll: true,
                        )),
                        FormBuilderValidators.minLength(3),
                        FormBuilderValidators.max(120),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  
                    FormBuilderRadioGroup<String>(
                      decoration: InputDecoration(
                        labelText: nt.t.form.org_type(
                          item: nt.t.organization_capitalized,
                        ),
                      ),
                      initialValue: null,
                      name: 'orgType',
                      onChanged: _onChanged,
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      options:
                          OrganizationType.getOrgTypeList()
                              .map((orgType) => FormBuilderFieldOption(
                                    value: orgType,
                                    child: Text(orgType),
                                  ))
                              .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                    ),
                    FormBuilderSwitch(
                      title: const Text('I Accept the terms and conditions'),
                      name: 'accept_terms_switch',
                      initialValue: true,
                      onChanged: _onChanged,
                    ),
                   
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            debugPrint(_formKey.currentState?.value.toString());
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                        child: const Text('Submit')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: const Text('Reset'),
                    ),
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
