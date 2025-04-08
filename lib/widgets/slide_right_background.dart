import 'package:flutter/material.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: const Align(
       alignment: Alignment.centerLeft,
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " ${nt.t.response.edit}",
            style: TextStyle(
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