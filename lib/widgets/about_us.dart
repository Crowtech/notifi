import 'package:flutter/material.dart';
import 'package:notifi/credentials.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;
import 'package:notifi/jwt_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';


Future<void> AboutUsDialog(BuildContext context, String appTitle, Widget logo)  async{
    PackageInfo packageInfo = await fetchPackageInfo();
    String deviceId = await fetchDeviceId();

    
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: logo,
          title:  Text(nt.t.about(name: appTitle)),
          content:  Text(nt.t.about_dialog(title: appTitle,version: packageInfo.version,deviceid: deviceId,project: defaultRealm.capitalise())),
          actions: <Widget>[
            // TextButton(
            //   style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
            //   child: const Text('Disable'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child:  Text(nt.t.response.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
