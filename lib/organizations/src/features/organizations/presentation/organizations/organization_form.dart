import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/email_validation.dart';
import 'package:notifi/forms/validations.dart/url_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/models/organization.dart';
import 'package:notifi/models/organization_type.dart';
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

class CreateOrganizationForm extends ConsumerStatefulWidget {
  CreateOrganizationForm({super.key, required this.formCode});

  String formCode;

  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState
    extends ConsumerState<CreateOrganizationForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> fieldValues = {};

  OrganizationType? orgTypeIndex;


  @override
  void initState() {
    super.initState();
    orgTypeIndex = OrganizationType.UNKNOWN;
    // ref.read(initialFormValidationsProvider("organization").notifier).add("orgType", false);
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
      fieldValues['orgType'] = orgTypeIndex!.name;
      ref
          .read(validateFormProvider("organization").notifier)
          .add("orgType", true);
      ref
          .read(enableWidgetProvider("false-url").notifier)
          .setEnabled(value.isUrlable);
    }
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
                  fieldValues: fieldValues,
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
                  regex: r"^[\p{L} ,.'-0-9]*$",
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  fieldValues: fieldValues,
                  formCode: widget.formCode,
                  fieldCode: "true-email",
                  enabled: true,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.email,
                  itemValidation: nt.t.form.email_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  onValidate: validateEmail,
                  regex: EMAIL_REGEX,
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
                  fieldValues: fieldValues,
                  formCode: widget.formCode,
                  fieldCode: "false-url",
                  enabled: false,
                  itemCategory: nt.t.organization,
                  itemName: nt.t.form.url,
                  itemValidation: nt.t.form.url_validation(
                    item: nt.t.organization_capitalized,
                  ),
                  regex: URL_REGEX,
                   optional: true,
                  forceLowercase: true,
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
                          ref.watch(validateFormProvider("${widget.formCode}"));
                      logNoStack.i("ORG_FORM: isValid $isValid");
                      return ElevatedButton(
                        key: const Key("organization-submit"),
                        onPressed: !isValid
                            ? null
                            : () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  var urlNotExisting = await validateUrlAsync(ref,context,
                                      fieldValues['url']!);

                                  if (urlNotExisting == false) {
                                    logNoStack.e(
                                        "error is ${nt.t.form.already_exists(item: nt.t.organization_capitalized, field: nt.t.form.url)}");
                                    StatusAlert.show(
                                      context,
                                      duration: const Duration(seconds: 4),
                                      //title: nt.t.organization,
                                      title: nt.t.form.already_exists(
                                          item: nt.t.organization_capitalized,
                                          field: nt.t.form.url),
                                      configuration: const IconConfiguration(
                                          icon: Icons.error),
                                      maxWidth: 300,
                                      dismissOnBackgroundTap: true,
                                    );
                                    
                                  } else {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.

                                    // save organization
                                    Organization organization = Organization(
                                      name: fieldValues['name'],
                                      description: fieldValues['description'],
                                      orgType: fieldValues['orgType']!,
                                      url: fieldValues['url']!,
                                      email: fieldValues['email']!,
                                      //email: _emailController.text,
                                    );
                                    var token = ref
                                        .read(nestAuthProvider.notifier)
                                        .token;
                                    var apiPath =
                                        "$defaultAPIBaseUrl$defaultApiPrefixPath/organizations/create";

                                    logNoStack.i(
                                        "ORG_FORM: sending ${organization} to ${apiPath}");
                                    apiPostDataNoLocaleRaw(
                                            token!, apiPath, organization)
                                        .then((result) {
                                      logNoStack.i("result is ${result}");

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
                                      logNoStack.e("error is ${error}");
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
