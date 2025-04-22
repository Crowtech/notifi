import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/org_list.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/email_validation.dart';
import 'package:notifi/forms/validations.dart/name_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/person.dart';
import 'package:notifi/persons/src/features/persons/data/persons_repository.dart';
import 'package:notifi/riverpod/validate_form.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:status_alert/status_alert.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

class CreatePersonForm extends ConsumerStatefulWidget {
  CreatePersonForm({super.key, required this.formCode});

  String formCode;

  @override
  _CreatePersonFormState createState() => _CreatePersonFormState();
}

class _CreatePersonFormState extends ConsumerState<CreatePersonForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> fieldValues = {};
   final givenNameController =TextEditingController();
    final familyNameController =TextEditingController();
  final emailController =TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    familyNameController.dispose();
    givenNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedItem = nt.t.person_capitalized;
    logNoStack.i("PERSON_FORM: BUILD ");
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
                  controller: givenNameController,
                  validationDebounce: const Duration(milliseconds: 500),
                  formCode: widget.formCode,
                  fieldCode: "true-given_name",
                  itemCategory: nt.t.person,
                  itemName: nt.t.form.given_name,
                  itemValidation: nt.t.form.given_name_validation(
                    item: nt.t.person_capitalized,
                  ),
                  hintText: nt.t.form.given_name_hint,
                  regex: NAME_REGEX,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  controller: familyNameController,
            
                  formCode: widget.formCode,
                  fieldCode: "true-family_name",
                  itemCategory: nt.t.person,
                  itemName: nt.t.form.family_name,
                  itemValidation: nt.t.form.family_name_validation(
                    item: nt.t.person_capitalized,
                  ),
                  hintText: nt.t.form.family_name_hint,
                  regex: NAME_REGEX,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  controller: emailController,
                 
                  formCode: widget.formCode,
                  fieldCode: "true-email",
                  enabled: true,
                  itemCategory: nt.t.person,
                  itemName: nt.t.form.email,
                  itemExists: nt.t.form.already_exists(item: nt.t.person_capitalized, field: nt.t.form.email),
                  itemValidation: nt.t.form.email_validation(
                    item: nt.t.person_capitalized,
                  ),
                  hintText: nt.t.form.email_hint,
                  onValidate: validateEmail,
                  regex: EMAIL_REGEX,
                  inputFormatters: emailInputFormatter,
                ),
                const SizedBox(height: 16),

                OrganizationListWidget(formKey: _formKey, formCode: widget.formCode, fieldValues: fieldValues, fieldCode: "orgids"),



                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CancelButtonWidget(
                        formKey: _formKey, formCode: widget.formCode),
                    const SizedBox(width: 16),
                    //SubmitButtonWidget(formKey: _formKey, formCode: widget.formCode)
                    Consumer(builder: (context, watch, child) {
                      bool isValid =
                          ref.watch(validateFormProvider(widget.formCode));
                      logNoStack.i("PERSON_FORM: isValid $isValid");
                      return ElevatedButton(
                        key: const Key("person-submit"),
                        onPressed: !isValid
                            ? null
                            : () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  var emailNotExisting =
                                      await validateEmailAsync(
                                          ref, context, fieldValues['email']!);

                                  if (emailNotExisting == false) {
                                    logNoStack.e(
                                        "error is ${nt.t.form.already_exists(item: nt.t.person_capitalized, field: nt.t.form.email)}");
                                    StatusAlert.show(
                                      context,
                                      duration: const Duration(seconds: 4),
                                      //title: nt.t.person,
                                      title: nt.t.form.already_exists(
                                          item: nt.t.person_capitalized,
                                          field: nt.t.form.email),
                                      configuration: const IconConfiguration(
                                          icon: Icons.error),
                                      maxWidth: 300,
                                      dismissOnBackgroundTap: true,
                                    );
                                  } else {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.

                                    // save person
                                    Person person = Person(
                                      firstname:
                                          fieldValues['given_name'], // name
                                      lastname: fieldValues[
                                          'family_name'], // description username
                                      email: fieldValues['email'], // email
                                    ); //fcm
                                    logNoStack.i('person form: ${fieldValues['orgIds']}');
                                    String queryParmOrgIds = "";
                                    for (int orgId in fieldValues['orgIds']) {
                                      queryParmOrgIds += "orgid=$orgId&";
                                    }
                                    queryParmOrgIds =queryParmOrgIds.substring(0,queryParmOrgIds.length-1);
                                    var token = ref
                                        .read(nestAuthProvider.notifier)
                                        .token;
                                    var apiPath =
                                        "$defaultAPIBaseUrl$defaultApiPrefixPath/persons/create?$queryParmOrgIds";

                                    logNoStack.i(
                                        "PERSON_FORM: sending $person to $apiPath");
                                    apiPostDataNoLocaleRaw(
                                            token!, apiPath, person)
                                        .then((result) {
                                      logNoStack.i("result is $result");

                                      StatusAlert.show(
                                        context,
                                        duration: const Duration(seconds: 2),
                                        title: nt.t.person,
                                        subtitle: nt.t.form.saved,
                                        configuration: const IconConfiguration(
                                            icon: Icons.done),
                                        maxWidth: 300,
                                      );
                                      ref.invalidate(fetchPersonsProvider);
                                      Navigator.of(context).pop();
                                    }, onError: (error) {
                                      logNoStack.e("error is $error");
                                      StatusAlert.show(
                                        context,
                                        duration: const Duration(seconds: 2),
                                        title: nt.t.person,
                                        subtitle: nt.t.form.error_saving,
                                        configuration: const IconConfiguration(
                                            icon: Icons.error),
                                        maxWidth: 300,
                                      );
                                    });
                                  }
                                }
                              },
                        child: Text(nt.t.response.submit),
                      );
                    })
                    //   },
                    //   ),
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
