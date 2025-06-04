import 'package:flutter/material.dart';

class CoreDropDown<T> extends StatelessWidget {
  const CoreDropDown({
    super.key,
    required this.builder,
    required this.items,
    required this.onSelected,
    this.value,
    this.placeholder,
    this.emptyField = false,
  });
  final String? value;
  final Widget Function(BuildContext, T) builder;
  final List<T> items;
  final Function(T?) onSelected;
  final String? placeholder;
  final bool emptyField;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, con) => DropdownMenu<T?>(
        controller: TextEditingController(text: value),
        onSelected: onSelected,
        textStyle: const TextStyle(fontSize: 12),
        enableSearch: true,
        width: con.maxWidth,
        hintText: placeholder,
        dropdownMenuEntries: [
          if (emptyField)
            const DropdownMenuEntry(
              label: "",
              labelWidget: Text("-- None --"),
              value: null,
            ),
          ...items.map(
            (item) => DropdownMenuEntry(
              label: "",
              labelWidget: builder(context, item),
              value: item,
            ),
          )
        ],
      ),
    );
  }
}
