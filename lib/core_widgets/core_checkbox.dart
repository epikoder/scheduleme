import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class CoreCheckbox extends StatelessWidget {
  const CoreCheckbox({
    super.key,
    required this.title,
    required this.checked,
    required this.onChanged,
    this.hint,
  });
  final String title;
  final String? hint;
  final bool checked;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      [
        Transform.scale(
          scale: .8,
          child: Checkbox(value: checked, onChanged: onChanged),
        ),
        Styled.text(title),
      ].toRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        separator: const SizedBox(
          width: 5,
        ),
      ),
      if (hint != null)
        [
          const SizedBox(
            width: 30,
          ),
          Styled.icon(Icons.info_outline).iconSize(12).padding(vertical: 2),
          Styled.text(hint!)
              .fontSize(12)
              .textColor(Colors.grey.shade600)
              .expanded(flex: 1),
        ].toRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            separator: const SizedBox(
              width: 5,
            )),
    ].toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
