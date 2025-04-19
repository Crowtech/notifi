import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/entities/user_role.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/models/person.dart';
import 'package:notifi/riverpod/notifications_data.dart';
import 'package:notifi/state/nest_auth2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

part 'info_widget.g.dart';

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

@riverpod
class InfoData extends _$InfoData {
  @override
  Map<String, dynamic> build(String code) {
    Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
    String? token = ref.read(nestAuthProvider.notifier).token;
    UserRole? userRole = getRole(token);
    bool hasExpired = false;
    hasExpired = JwtDecoder.isExpired(token!);
    if (hasExpired) {
      logNoStack.e("Permissions: User  token has expired");
      userRole = const UserRole.none();
    }
    DateTime expirationDate = JwtDecoder.getExpirationDate(token);

    // 2025-01-13 13:04:18.000
    logNoStack.i("token expiry datetime is $expirationDate");
    // use token to extract roles
    Duration tokenTime = JwtDecoder.getTokenTime(token!);
    logNoStack.i("token duration is ${tokenTime.inMinutes} for $token");

    Map<String, dynamic> jwtMap = JwtDecoder.decode(token);
    logNoStack.i("PERMISSIONS: JWT Map is $jwtMap");
    List rolesList = jwtMap['realm_access']['roles'];
    String rolesStr = "";
    for (var i = 0; i < rolesList.length; i++) {
      if (rolesList[i] != null) {
        rolesStr += "${rolesList[i]}\n";
      }
    }
    logNoStack.i("PERMISSIONS: Roles for user are $rolesStr");
    return {
      "Name": currentUser.name,
      "Code": currentUser.code,
      "Email": currentUser.email,
      "Gender": currentUser.gender.name,
      "Avatar Url": currentUser.getAvatarUrl(),
      "GPS": currentUser.gps,
      "User resource Type": currentUser.resourceType.name,
      "user Language": currentUser.i18n,
      "User Initials": currentUser.getInitials(),
      "Roles": rolesStr,
      "Token expired?": hasExpired ? "TOKEN EXPIRED" : "TOKEN NOT EXPIRED",
      "Token expiry DateTime": "Expiry date: ${expirationDate.toString()}",
      "Token Duration": "token duration is ${tokenTime.inMinutes} minutes",
      "Main Role": "${userRole}",
      "TOKEN": "${token}",
      "Device ID": "${currentUser.devicecode}",
      "fcm": "${currentUser.fcm}",
      
    };
  }

  void update(String key, dynamic value) {
    Map<String, dynamic> rowMap = {};
    rowMap[key] = value;
    state = {...state, ...rowMap};
  }


  void clear() {
    state = {};
  }
}

class InfoWidget extends ConsumerWidget {
  InfoWidget({super.key, required this.code});

  late String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableData = ref.watch(infoDataProvider(code));
    final notificationData = ref.watch(notificationsDataProvider(code));

    if (notificationData.isNotEmpty) {
      tableData.addAll(notificationData);
    }

    Table table = Table(
      border: TableBorder(
          horizontalInside: BorderSide(color: Colors.black, width: 10.0)),
      children: [
        //This table row is for the table header which is static
        const TableRow(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "INDEX",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "NAME",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "DATA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),
        ]),
        // Using the spread operator to add the remaining table rows which have dynamic data
        // Be sure to use .asMap().entries.map if you want to access their indexes and objectName.map() if you have no interest in the items index.

        ...tableData.entries.map(
          (row) {
            return TableRow(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        row.key,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        logNoStack.i("Tapped on ${row.value}");
                        Clipboard.setData(ClipboardData(text: row.value))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  nt.t.copied_to_clipboard(item: nt.t.text))));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '${row.value} ',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (val) {},
                        value: false,
                      ),
                    ),
                  ),
                ]);
          },
        )
      ],
    );

    return table;
  }
}
