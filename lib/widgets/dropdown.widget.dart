import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownPage extends StatefulWidget {
  final String title;
  final List<String> items;
  final TextEditingController controller;
  final bool isShowTitle;
  final bool isShowPlaceholder;
  final Function(String)? onChanged;

  const CustomDropdownPage({
    super.key,
    required this.title,
    required this.items,
    required this.controller,
    this.isShowTitle = true,
    this.isShowPlaceholder = true,
    this.onChanged,
  });

  @override
  _CustomDropdownPageState createState() => _CustomDropdownPageState();
}

class _CustomDropdownPageState extends State<CustomDropdownPage> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value:
                _selectedItem ?? widget.controller.text,
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? selectedItem) {
              setState(() {
                _selectedItem = selectedItem;
                widget.controller.text = selectedItem ?? '';
              });
              if (widget.onChanged != null) {
                widget.onChanged!(selectedItem ?? '');
              }
            },
            decoration: InputDecoration(
              hintText: widget.isShowPlaceholder
                  ? !widget.isShowTitle
                      ? widget.title
                      : null
                  : null,
              contentPadding: const EdgeInsets.all(12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final TextEditingController controller;
  final bool isShowTitle;
  final bool isShowPlaceholder;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? defaultAnswer;
  final GlobalKey<DropdownButton2State> dropdownKey;

  const CustomDropdown(
      {super.key,
      required this.title,
      required this.items,
      required this.controller,
      this.isShowTitle = true,
      this.isShowPlaceholder = true,
      this.onChanged,
      this.focusNode,
      required this.dropdownKey,
      this.defaultAnswer});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.defaultAnswer;
    // print("Below is slecte Item " + _selectedItem.t);

    widget.controller.text = _selectedItem ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
            ),
          ),
          child: DropdownButtonFormField2<String>(
            // focusNode: widget.focusNode,
            dropdownButtonKey: widget.dropdownKey,
            value: _selectedItem,
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? selectedItem) {
              setState(() {
                _selectedItem = selectedItem;
                widget.controller.text = selectedItem ?? '';
              });
              if (widget.onChanged != null) {
                widget.onChanged!(selectedItem ?? '');
              }
            },

            decoration: InputDecoration(
              hintText: widget.isShowPlaceholder ? widget.title : null,
              contentPadding: const EdgeInsets.all(12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
