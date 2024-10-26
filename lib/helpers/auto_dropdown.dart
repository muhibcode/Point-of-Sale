import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:flutter/material.dart';

class AutoCompDrop extends StatefulWidget {
  final initalVal;
  final List<Map<String, dynamic>> items;
  final String title;
  final select;
  final onSelect;
  final double width;
  const AutoCompDrop({
    super.key,
    this.initalVal,
    required this.items,
    required this.title,
    this.select,
    this.onSelect,
    required this.width,
  });

  @override
  State<AutoCompDrop> createState() => _AutoCompDropState();
}

class _AutoCompDropState extends State<AutoCompDrop> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      onSelected: widget.onSelect,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.items.where((option) {
          return option[widget.select]
              .toString()
              .toLowerCase()
              .startsWith(textEditingValue.text.toLowerCase());
        });
      },
      optionsViewBuilder: (context, Function onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.width),
              child: ListView.builder(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.only(right: 50),
                  itemBuilder: (context, index) {
                    dynamic option = options.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // contentPadding: EdgeInsets.only(left: 10),
                        hoverColor: Colors.white.withOpacity(0.1),
                        title: Text(option[widget.select]),

                        onTap: () {
                          // print(widget.items[index]['id']);
                          onSelected(option[widget.select]);
                          menuController.idVal.value =
                              widget.items[index]['id'].toString();

                          // widget.initalVal == ''
                          //     ?
                          // setState(() {
                          // });
                          //     onSelected(option[widget.select])
                          //     : onSelected(widget.initalVal);
                        },
                      ),
                    );
                  },
                  itemCount: options.length),
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        textEditingController.text = widget.initalVal;

        return TextFieldSubmit(
            focusNode: focusNode,
            submitted: false,
            label: widget.title,
            controller: textEditingController,
            onTap: () => textEditingController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: textEditingController.value.text.length));
      },
    );
  }
}
