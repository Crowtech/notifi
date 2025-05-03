import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/code_validation.dart';
import 'package:notifi/forms/validations.dart/description_validation.dart';
import 'package:notifi/forms/validations.dart/name_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/message_template.dart';
import 'package:notifi/models/organization_type.dart';
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

typedef SubmitFunction<String> = void Function(String value);

class CreateTemplateForm extends ConsumerStatefulWidget {
  CreateTemplateForm(
      {super.key,
      required this.formCode,
      required this.templateCode,
      required this.onSubmit});

  String formCode;
  String templateCode;
  SubmitFunction<String>? onSubmit;

  @override
  _CreateTemplateFormState createState() => _CreateTemplateFormState();
}

class _CreateTemplateFormState extends ConsumerState<CreateTemplateForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> fieldValues = {};

  OrganizationType? orgTypeIndex;
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ref.read(initialFormValidationsProvider("organization").notifier).add("orgType", false);
  }

  @override
  void dispose() {
    codeController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<bool> defaultValidate(String value) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedItem = nt.t.template_capitalized;
    logNoStack.i("TEMPLATE_FORM: BUILD ");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   nt.t.form.create(item: capitalizedItem),
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                controller: codeController,
                fieldValues: fieldValues,
                formCode: widget.formCode,
                fieldCode: "true-code",
                enabled: true,
                itemCategory: nt.t.template,
                itemName: nt.t.form.code,
                itemValidation: nt.t.form.code_validation(
                  item: nt.t.template_capitalized,
                ),
                hintText: nt.t.form.code_hint(
                  item: nt.t.template_capitalized,
                ),
                //onValidate: validateCode,
                regex: CODE_REGEX,
                //inputFormatters: codeInputFormatter,
                //textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                controller: nameController,
                fieldValues: fieldValues,
                formCode: widget.formCode,
                fieldCode: "true-name",
                enabled: true,
                itemCategory: nt.t.template,
                itemName: nt.t.form.name,
                itemValidation: nt.t.form.name_validation(
                  item: nt.t.template_capitalized,
                ),
                hintText: nt.t.form.name_hint,
                onValidate: validateName,
                regex: NAME_REGEX,
                inputFormatters: nameInputFormatter,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              TextFormFieldWidget(
                controller: descriptionController,
                fieldValues: fieldValues,
                formCode: widget.formCode,
                fieldCode: "true-description",
                enabled: true,
                itemCategory: nt.t.template,
                itemName: nt.t.form.description(
                  item: nt.t.template_capitalized,
                ),
                itemValidation: nt.t.form.description_validation(
                  item: nt.t.template_capitalized,
                ),
                hintText: nt.t.form.description_hint,
                onValidate: validateDescription,
                regex: DESCRIPTION_REGEX,
                inputFormatters: descriptionInputFormatter,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 16),
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
                    logNoStack.i("TEMPLATE_FORM: isValid $isValid");
                    return ElevatedButton(
                      key: const Key("template-submit"),
                      onPressed: !isValid
                          ? null
                          : () async {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                widget.templateCode = fieldValues['code'];
                                widget.onSubmit!(widget.templateCode);
                                // save template
                                MessageTemplate template = MessageTemplate(
                                  code: fieldValues['code'],
                                  name: fieldValues['name'],
                                  description: fieldValues['description'],
                                );
                                var token =
                                    ref.read(nestAuthProvider.notifier).token;
                                var apiPath =
                                    "$defaultAPIBaseUrl$defaultApiPrefixPath/messagetemplates/create?isauthorized=${fieldValues['authorized']}";

                                logNoStack.i(
                                    "TEMPLATE_FORM: sending $template to $apiPath");
                                apiPostDataNoLocaleRaw(
                                        token!, apiPath, template)
                                    .then((result) {
                                  logNoStack.i("result is $result");

                                  StatusAlert.show(
                                    context,
                                    duration: const Duration(seconds: 2),
                                    title: nt.t.template,
                                    subtitle: nt.t.form.saved,
                                    configuration: const IconConfiguration(
                                        icon: Icons.done),
                                    maxWidth: 300,
                                  );
                                  // ref.invalidate(
                                  //     fetchTemplateNestFilterProvider);
                                  Navigator.of(context).pop();
                                }, onError: (error) {
                                  logNoStack.e("error is $error");
                                  StatusAlert.show(
                                    context,
                                    duration: const Duration(seconds: 2),
                                    title: nt.t.template,
                                    subtitle: nt.t.form.error_saving,
                                    configuration: const IconConfiguration(
                                        icon: Icons.error),
                                    maxWidth: 300,
                                  );
                                });
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
    );
  }
}
