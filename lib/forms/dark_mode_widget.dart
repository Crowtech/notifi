import 'package:flutter/material.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class CustomModeSwitch extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const CustomModeSwitch({
    Key? key,
    required this.isDarkMode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [!isDarkMode, isDarkMode],
      onPressed: (index) {
        onChanged(index == 1);
      },
      borderRadius: BorderRadius.circular(20),
      selectedColor: Colors.white,
      fillColor: Theme.of(context).colorScheme.primary,
      constraints: BoxConstraints(minHeight: 40.0, minWidth: 100.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.wb_sunny),
            SizedBox(width: 8),
            Text(nt.t.light),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.nights_stay),
            SizedBox(width: 8),
            Text(nt.t.dark),
          ],
        ),
      ],
    );
  }
}