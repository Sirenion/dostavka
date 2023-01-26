import 'package:dostavka/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DTextField extends StatelessWidget {
  const DTextField({Key? key,
    required this.label,
    this.onChanged,
    this.textEditingController,
    this.keyboardType,
    this.isError = false,
    this.typeFormat = 0,
    this.maxLength,
  }) : super(key: key);

  final String label;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool isError;
  final int typeFormat;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final _numFormatter = NumberTextInputFormatter();
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLength: (typeFormat == 1) ? 16 : maxLength,
      inputFormatters: <TextInputFormatter>[
        if (typeFormat == 1) ...[
          FilteringTextInputFormatter(RegExp(r'[+0-9]'), allow: true),
          _numFormatter,
        ],
        if (typeFormat == 2) ...[
          FilteringTextInputFormatter(RegExp(r'[0-9А-Яа-я]'), allow: true),
        ],
        if (typeFormat == 3) ...[
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
        ],
        if (typeFormat == 4) ...[
          FilteringTextInputFormatter(RegExp(r'[ 0-9]'), allow: true),
        ]
      ],
      style: const TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
        color: Color(0xFF2D3A52),
      ),
      decoration: isError ? _decorationError(label) : _decoration(label),
    );
  }
}

class DTextFieldSecondary extends StatelessWidget {
  const DTextFieldSecondary({Key? key,
    required this.label,
    this.onChanged,
    this.isError = false,
  }) : super(key: key);

  final String label;
  final ValueChanged<String>? onChanged;
  final bool isError;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      style: const TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
        color: Color(0xFF2D3A52),
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
             color: isError ? Colors.red : const Color(0xFF2D3A52),
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        labelText: label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            color: isError ? Colors.red : const Color(0xFF2D3A52) ,
            fontWeight: FontWeight.w600,
            fontSize: 17
        ),
        contentPadding: const EdgeInsets.all(17.0),
      ),
    );
  }
}

class DTextFieldDropdown extends StatelessWidget {
  const DTextFieldDropdown({Key? key,
    required this.label,
    required this.entries,
    required this.controller,
  }) : super(key: key);

  final String label;
  final List<String> entries;
  final Function(String) controller;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        builder: (FormFieldState<String> state) {
          return DropdownButtonFormField<String>(
            onChanged: (val) {
              controller(val!);
            },
            decoration: _decoration(label),
            icon: Transform.rotate(
              angle: (-90.0 * 3.14 / 180.0),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF2D3A52),
                size: 20.0,
              ),
            ),
            items: entries.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: TextView(
                  text: value,
                  fs: 17,
                  fw: FontWeight.w600,
                ),
              );
            }).toList(),
          );
        }
    );
  }
}

class DTextArea extends StatelessWidget {
  const DTextArea({Key? key,
    required this.label,
    this.isError = false,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final ValueChanged<String>? onChanged;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      expands: true,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
      style: const TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
        color: Color(0xFF2D3A52),
      ),
      decoration: isError ? _decorationError(label) : _decoration(label),
    );
  }
}

class DAutoCompleteTextField extends StatelessWidget {
  const DAutoCompleteTextField({Key? key,
    required this.label,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: const TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
        color: Color(0xFF2D3A52),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        hintText: label,
        hintStyle: const TextStyle(
          fontFamily: 'Exo2.0',
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          color: Color.fromRGBO(45, 58, 82, .3),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class DTextDropdown extends StatelessWidget {
  const DTextDropdown({Key? key,
    required this.label,
    required this.controller,
    this.isError = false,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool isError;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      enabled: false,
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        fontFamily: 'Exo2.0',
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
        color: Color(0xFF2D3A52),
      ),
      decoration: isError ? _decorationError(label, ico: true) : _decoration(label, ico: true),
    );
  }
}


_decoration(String label, {
  bool ico = false }) {
  return InputDecoration(
    counterText: "",
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xFF2D3A52),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xFF2D3A52),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xFF2D3A52),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Color(0xFF2D3A52)),
    ),
    labelText: label,
    alignLabelWithHint: true,
    labelStyle: const TextStyle(
        color: Color(0xFF2D3A52),
        fontWeight: FontWeight.w600,
        fontSize: 17
    ),
    suffixIcon: ico ? Transform.rotate(
      angle: (-90.0 * 3.14 / 180.0),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Color(0xFF2D3A52),
        size: 20.0,
      ),
    ) : null,
    contentPadding: const EdgeInsets.all(17.0),
  );
}

_decorationError(String label, {
  bool ico = false }) {
  return InputDecoration(
    counterText: "",
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Color(0xFF2D3A52),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
          color: Colors.red
      ),
    ),
    labelText: label,
    alignLabelWithHint: true,
    labelStyle: const TextStyle(
        color: Colors.red ,
        fontWeight: FontWeight.w600,
        fontSize: 17
    ),
    suffixIcon: ico ? Transform.rotate(
      angle: (-90.0 * 3.14 / 180.0),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Color(0xFF2D3A52),
        size: 20.0,
      ),
    ) : null,
    contentPadding: const EdgeInsets.all(17.0),
  );
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 2;
    final newTextBuffer = StringBuffer();

    if (newTextLength >= 1) {
        if (newTextLength == 1) {
          usedSubstringIndex = 1;
        } else {
          usedSubstringIndex = 2;
        }
        if (newValue.text.startsWith(RegExp(r'(\+|7)'))) {
          newTextBuffer.write('+7');
          if (newValue.selection.end >= 1) selectionIndex++;
        } else {
          newTextBuffer.write('+7 ' + newValue.text);
          selectionIndex = 4;
        }
    }

    if (newTextLength >= 3) {
      newTextBuffer
          .write(' ' + newValue.text.substring(2, usedSubstringIndex = 2));
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newTextLength >= 6) {
      newTextBuffer.write(
          newValue.text.substring(usedSubstringIndex, usedSubstringIndex = 5) +
              ' ');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newTextLength >= 9) {
      newTextBuffer.write(
          newValue.text.substring(usedSubstringIndex, usedSubstringIndex = 8) +
              '-');
      if (newValue.selection.end >= 8) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newTextBuffer.write(
          newValue.text.substring(usedSubstringIndex, usedSubstringIndex = 10) +
              '-');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
// Dump the rest.
    if (newTextLength > usedSubstringIndex) {
      newTextBuffer.write(
        newValue.text.substring(usedSubstringIndex, newTextLength));
    }

    if (selectionIndex > newTextBuffer.length) {
      selectionIndex = newTextBuffer.length;
    }
    return TextEditingValue(
      text: newTextBuffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}



