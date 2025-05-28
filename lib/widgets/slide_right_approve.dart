import 'package:flutter/material.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

Widget slideRightApprove() {
  return Container(
    color: Colors.green,
    child: Align(
       alignment: Alignment.centerLeft,
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " ${nt.t.invite.approve}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
     
    ),
  );
}