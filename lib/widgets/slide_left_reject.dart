import 'package:flutter/material.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

Widget slideLeftReject() {
  return Container(
    color: Colors.red,
    child: Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Icon(
            Icons.delete,
            color:  Color.fromARGB(255, 6, 5, 5),
          ),
          Text(
            " ${nt.t.invite.reject}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}
