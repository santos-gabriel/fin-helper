import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List types;
  final bool isExpanded;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const CustomDropdownButton({
    Key? key,
    required this.types,
    required this.isExpanded,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  List<DropdownMenuItem<String>>? _dropDownMenuItems;
  String? _currentType;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentType = _dropDownMenuItems![0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String type in widget.types) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedDropDownItem(String selectedType) {
    setState(() {
      _currentType = selectedType;
    });
    widget.onChanged!(selectedType);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: widget.isExpanded,
      value: _currentType != null ? _currentType : _dropDownMenuItems![0].value,
      items: _dropDownMenuItems,
      onChanged: (value) {
        changedDropDownItem(value.toString());
      },
      validator: widget.validator,
    );
  }
}
