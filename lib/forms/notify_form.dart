import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/api_utils.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/forms/cancel_button_widget.dart';
import 'package:notifi/forms/text_form_widget.dart';
import 'package:notifi/forms/validations.dart/email_validation.dart';
import 'package:notifi/forms/validations.dart/message_validation.dart';
import 'package:notifi/forms/validations.dart/subject_validation.dart';
import 'package:notifi/forms/validations.dart/topic_validation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
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

class NotifyForm extends ConsumerStatefulWidget {
  NotifyForm({super.key, required this.formCode});

  String formCode;

  @override
  _NotifyFormState createState() => _NotifyFormState();
}

class _NotifyFormState extends ConsumerState<NotifyForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> fieldValues = {};
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final topicController = TextEditingController();
  final usernameController = TextEditingController();
  final fcmController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    topicController.dispose();
    usernameController.dispose();
    fcmController.dispose();
    super.dispose();
  }

  Future<bool> defaultValidate(String value) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedItem = nt.t.person_capitalized;
    logNoStack.i("NOTIFY_FORM: BUILD ");

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: AnimatedSize(
                    // animate changes in size, when the list
                    //size is changing, e.g. search functionality
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Text(
                          nt.t.messages,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: subjectController,
                          validationDebounce: const Duration(milliseconds: 500),
                          fieldValues: fieldValues,
                          formCode: widget.formCode,
                          fieldCode: "true-subject",
                          itemCategory: nt.t.subject,
                          itemName: nt.t.subject,
                          itemValidation: nt.t.form.subject_validation(
                            item: nt.t.subject_capitalized,
                          ),
                          hintText: nt.t.form.subject_hint,
                          regex: SUBJECT_REGEX,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: messageController,
                          fieldValues: fieldValues,
                          formCode: widget.formCode,
                          fieldCode: "true-message",
                          itemCategory: nt.t.form.message,
                          itemName: nt.t.form.message,
                          itemValidation: nt.t.form.message_validation,
                          hintText: nt.t.form.message_hint,
                          regex: MESSAGE_REGEX,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: usernameController,
                          fieldValues: fieldValues,
                          // isValidatingMessage:
                          //     nt.t.form.validating(field: nt.t.form.username),
                          formCode: widget.formCode,
                          fieldCode: "true-username",
                          enabled: true,
                          optional: true,
                          itemCategory: nt.t.form.username,
                          itemName: nt.t.form.username,
                          itemValidation: nt.t.form.username_validation,
                          hintText: nt.t.form.username_hint,
                          regex: EMAIL_REGEX,
                          inputFormatters: emailInputFormatter,
                        ),
                        const SizedBox(height: 16),
                        TextFormFieldWidget(
                          controller: topicController,
                          fieldValues: fieldValues,
                          // isValidatingMessage:
                          //     nt.t.form.validating(field: nt.t.form.topic),
                          formCode: widget.formCode,
                          fieldCode: "true-topic",
                          enabled: true,
                          optional: true,
                          itemCategory: nt.t.form.topic,
                          itemName: nt.t.form.topic,
                          itemValidation: nt.t.form.topic_validation(
                            item: nt.t.topic_capitalized,
                          ),
                          hintText: nt.t.form.topic_hint(
                            item: nt.t.topic_capitalized,
                          ),
                          regex: TOPIC_REGEX,
                          inputFormatters: topicInputFormatter,
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
                              bool isValid = ref
                                  .watch(validateFormProvider(widget.formCode));
                              logNoStack.i("NOTIFY_FORM: isValid $isValid");
                              // bool validGroupOk = true;
                              // int count=0;
                              // if (fieldValues.isNotEmpty) {
                              // for (String key in fieldValues.keys) {
                              //   validGroupOk &= fieldValues[key];
                              //   if (fieldValues[key]) count++;
                              // }
                              // }
                              // validGroupOk = validGroupOk && (count > 2);
                              return ElevatedButton(
                                key: const Key("notify-submit"),
                                onPressed: (!isValid && true/*!validGroupOk*/)
                                    ? null
                                    : () async {
                                      logNoStack.i("NOTIFY_FORM: Send onPressed");
                                        if (_formKey.currentState != null &&
                                            _formKey.currentState!.validate()) {
                                               logNoStack.i("NOTIFY_FORM: Send onPressed and Valid");
//"https://pantag.crowtech.com.au/g/firebase/send/${TITLE}/${MESSAGE}?fcm=${FCM}&usercode=${USERCODE}&username=${USERNAME}&topic=${TOPIC}"  -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}"`
                                          // send message
                                          String subject =
                                              fieldValues['subject'];
                                          String message =
                                              fieldValues['message'];
                                          String fcm = fieldValues['fcm'];
                                          String username =
                                              fieldValues['username'];
                                          String topic = fieldValues['topic'];
                                          var token = ref
                                              .read(nestAuthProvider.notifier)
                                              .token;
                                          var apiPath =
                                              "$defaultAPIBaseUrl$defaultApiPrefixPath/notifications/send/$subject/$message?fcm=$fcm&username=$username&topic=$topic";

                                          logNoStack.i(
                                              "NOTIFY_FORM: sending message to $apiPath");
                                          apiGet(token!, apiPath).then(
                                              (result) {
                                            logNoStack.i("result is $result");

                                            StatusAlert.show(
                                              context,
                                              duration:
                                                  const Duration(seconds: 2),
                                              title: nt.t.form.message,
                                              subtitle: nt.t.form.saved,
                                              configuration:
                                                  const IconConfiguration(
                                                      icon: Icons.done),
                                              maxWidth: 300,
                                            );

                                            Navigator.of(context).pop();
                                          }, onError: (error) {
                                            logNoStack.e("error is $error");
                                            StatusAlert.show(
                                              context,
                                              duration:
                                                  const Duration(seconds: 2),
                                              title: nt.t.form.message,
                                              subtitle: nt.t.form.error_saving,
                                              configuration:
                                                  const IconConfiguration(
                                                      icon: Icons.error),
                                              maxWidth: 300,
                                            );
                                          });
                                        } else {
                                           logNoStack.i("NOTIFY_FORM: Send onPressed NOT VALID");
                                        }
                                      },
                                child: Text(nt.t.response.send),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
