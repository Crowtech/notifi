import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/checkbox_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/description_validation.dart';
import 'package:notifi/forms/validations.dart/email_validation.dart';
import 'package:notifi/forms/validations.dart/name_validation.dart';
import 'package:notifi/forms/validations.dart/url_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/organization_type.dart';
import '../../domain/norganization.dart';
import 'package:notifi/organizations/src/features/organizations/data/organizations_repository_nf.dart';
import 'package:notifi/riverpod/enable_widget.dart';
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

class CreateNOrganizationForm extends ConsumerStatefulWidget {
  CreateNOrganizationForm({super.key, required this.formCode});

  String formCode;

  @override
  _CreateNOrganizationFormState createState() => _CreateNOrganizationFormState();
}

class _CreateNOrganizationFormState
    extends ConsumerState<CreateNOrganizationForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> fieldValues = {};

  OrganizationType? orgTypeIndex;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    orgTypeIndex = OrganizationType.UNKNOWN;
    // ref.read(initialFormValidationsProvider("organization").notifier).add("orgType", false);
  }

  @override
  void dispose() {
    emailController.dispose();
    urlController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _handleRadioValueChanged(OrganizationType? value) {
    if (value != null) {
      setState(() {
        orgTypeIndex = value;
        logNoStack.i(orgTypeIndex!.name);
      });
      fieldValues['orgType'] = orgTypeIndex!.name;
      ref
          .read(validateFormProvider("organization").notifier)
          .add("orgType", true);

      ref
          .read(enableWidgetProvider("false-email").notifier)
          .setEnabled(value.isUrlable);
      ref
          .read(enableWidgetProvider("false-url").notifier)
          .setEnabled(value.isUrlable);
      ref
          .read(enableWidgetProvider("authorized").notifier)
          .setEnabled(value.isUrlable);
    }
  }

  Future<bool> defaultValidate(String value) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // var watch = ref.watch(refreshWidgetProvider("organization"));
    String capitalizedItem = nt.t.organization_capitalized;
    logNoStack.i("ORG_FORM: BUILD ");
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
                  controller: nameController,
                  fieldValues: fieldValues,
                  formCode: widget.formCode,
                  fieldCode: "true-name",
                  enabled: true,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.name,
                  itemValidation: nt.t.form.name_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  hintText: nt.t.form.name_hint,
                  onValidate: validateName,
                  regex: NAME_REGEX,
                  inputFormatters: nameInputFormatter,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  controller: descriptionController,
                  fieldValues: fieldValues,
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
                  hintText: nt.t.form.description_hint,
                  onValidate: validateDescription,
                  regex: DESCRIPTION_REGEX,
                  inputFormatters: descriptionInputFormatter,
                  textCapitalization: TextCapitalization.sentences,
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
                CheckboxFormFieldWidget(
                    fieldValues: fieldValues,
                    formCode: widget.formCode,
                    fieldCode: "authorized",
                    initialValue: false,
                    itemCategory: nt.t.organization,
                    itemName: nt.t.form
                        .authorized(item: nt.t.organization_capitalized)),
                TextFormFieldWidget(
                  controller: emailController,
                  fieldValues: fieldValues,
                  valueIsExisting: nt.t.form.already_exists(
                      item: nt.t.organization_capitalized,
                      field: nt.t.form.email),
                  formCode: widget.formCode,
                  fieldCode: "false-email",
                  enabled: false,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.email_administration(
                    item: nt.t.organization_capitalized,
                  ),
                  itemValidation: nt.t.form.email_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  hintText: nt.t.form.email_administration_hint(
                    item: nt.t.organization_capitalized,
                  ),
                  onValidate: validateEmail,
                  regex: EMAIL_REGEX,
                  inputFormatters: emailInputFormatter,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  controller: urlController,
                  fieldValues: fieldValues,
                  isValidatingMessage:
                      nt.t.form.validating(field: nt.t.form.url),
                  valueIsExisting: nt.t.form.already_exists(
                      item: nt.t.organization_capitalized,
                      field: nt.t.form.url),
                  formCode: widget.formCode,
                  fieldCode: "false-url",
                  enabled: false,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.url,
                  itemValidation: nt.t.form.url_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  hintText:
                      nt.t.form.url_hint(item: nt.t.organization_capitalized),
                //  onValidate: validateUrl,
                  regex: URL_REGEX,
                //  inputFormatters: urlInputFormatter,
                  optional: false,
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
                      logNoStack.i("ORG_FORM: isValid $isValid");
                      return ElevatedButton(
                        key: const Key("organization-submit"),
                        onPressed: !isValid
                            ? null
                            : () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  // save organization
                                  NOrganization organization = NOrganization(
                                    name: fieldValues['name'],
                                    description: fieldValues['description'],
                                    orgType: fieldValues['orgType']!,
                                    url: fieldValues['url']!,
                                    email: fieldValues['email']!,
                                    //email: _emailController.text,
                                  );
                                  var token =
                                      ref.read(nestAuthProvider.notifier).token;
                                  var apiPath =
                                      "$defaultAPIBaseUrl$defaultApiPrefixPath/organizations/create?isauthorized=${fieldValues['authorized']?'true':'false'}";

                                  logNoStack.i(
                                      "ORG_FORM: sending $organization to $apiPath");
                                  apiPostDataNoLocaleRaw(
                                          token!, apiPath, organization)
                                      .then((result) {
                                    logNoStack.i("result is $result");

                                    StatusAlert.show(
                                      context,
                                      duration: const Duration(seconds: 2),
                                      title: nt.t.organization,
                                      subtitle: nt.t.form.saved,
                                      configuration: const IconConfiguration(
                                          icon: Icons.done),
                                      maxWidth: 300,
                                    );
                                    ref.invalidate(
                                        fetchOrganizationsNestFilterProvider);
                                    Navigator.of(context).pop();
                                  }, onError: (error) {
                                    logNoStack.e("error is $error");
                                    StatusAlert.show(
                                      context,
                                      duration: const Duration(seconds: 2),
                                      title: nt.t.organization,
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
      ),
    );
  }
}
