import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/form_builder/form_builder_creator.dart';
import 'package:scheduleme/services/space/appointment/form.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomizeAppointmentFormPartial extends ConsumerStatefulWidget {
  const CustomizeAppointmentFormPartial({super.key, required this.formId});
  final String formId;

  @override
  CustomizeAppointmentFormPartialState createState() =>
      CustomizeAppointmentFormPartialState();
}

class CustomizeAppointmentFormPartialState
    extends ConsumerState<CustomizeAppointmentFormPartial> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(getAppointmentFormProvider.notifier)
          .getAppointmentFormById("space_id", "form_id");
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final creator =
        context.getInheritedWidgetOfExactType<FormCreatorProvider>()!;
    final state = ref.watch(getAppointmentFormProvider);
    ref.listen(getAppointmentFormProvider, (_, value) {
      // TODO: set default / current form fields
      switch (value) {
        case AsyncData(:final value):
          // value.unwrap();
          break;
        default:
      }
    });

    return ValueListenableBuilder(
      valueListenable: creator.controller,
      builder: (ctx, fields, _) {
        final contents = [
          DragAndDropList(
            contentsWhenEmpty: Styled.text("Add a Form Field")
                .textColor(Colors.grey.shade500)
                .textStyle(const TextStyle(fontStyle: FontStyle.italic)),
            children: fields
                .map(
                  (fieldInput) => DragAndDropItem(
                    child: FormCreatorField(
                      fieldInput: fieldInput,
                      controller: creator.controller,
                    ),
                  ),
                )
                .toList(),
          )
        ];
        return [
          Styled.text("Drag to rearrange & don't forget to save")
              .textColor(Colors.grey.shade500),
          DragAndDropLists(
            children: contents,
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
          ).height(MediaQuery.of(context).size.height - 80)
        ].toColumn(
            separator: const SizedBox(
          height: 10,
        ));
      },
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final controller = context
        .getInheritedWidgetOfExactType<FormCreatorProvider>()!
        .controller;
    var movedItem = controller.removeAt(oldItemIndex);
    controller.insert(newItemIndex, movedItem);
  }

  _onListReorder(int oldListIndex, int newListIndex) {}
}
