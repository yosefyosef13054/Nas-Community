import 'package:flutter/services.dart';


class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  final String _anyCharMask = '#';
  final String _onlyDigitMask = '0';
  final RegExp? anyCharMatcher;
  String _lastValue = '';


  MaskedTextInputFormatter(
      this.mask, {
        this.anyCharMatcher,
      });

  bool get isFilled => mask.length == _lastValue.length;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final bool isErasing = newValue.text.length < oldValue.text.length;

    if (isErasing || _lastValue == newValue.text) {
      _lastValue = newValue.text;
      return newValue;
    }

    final String masked = applyMask(
      newValue.text,
    );
    final end = newValue.text.length - newValue.selection.end;

    _lastValue = masked;
    return TextEditingValue(
      text: masked,
      selection: TextSelection.collapsed(
        offset: masked.length - end,
      ),
    );
  }

  bool _isMatchingRestrictor(String character) {
    if (anyCharMatcher == null) {
      return true;
    }
    return anyCharMatcher!.stringMatch(character) != null;
  }

  String applyMask(String text) {
    final List<String> chars = text.split('');
    final List<String> result = <String>[];

    int maskShift = 0;
    for (int i = 0; i < mask.length; i++) {
      final int maskIndex = i + maskShift;
      if (chars.length <= i || mask.length <= maskIndex) break;
      final String currentChar = chars[i];
      final maskChar = mask[maskIndex];
      if (currentChar == maskChar) {
        result.add(currentChar);
      } else if (maskChar == _anyCharMask) {
        if (_isMatchingRestrictor(currentChar)) {
          result.add(currentChar);
        } else {
          break;
        }
      } else if (maskChar == _onlyDigitMask) {
        if (isDigit(currentChar)) {
          result.add(currentChar);
        } else {
          break;
        }
      } else {
        result.add(maskChar);
        if (_isMatchingRestrictor(currentChar)) {
          result.add(currentChar);
          maskShift++;
        }
      }
    }

    return result.join();
  }
}

bool isDigit(String character) {
  final RegExp _digitRegExp = RegExp(r'[-0-9]+');
  if (character.isEmpty || character.length > 1) {
    return false;
  }
  return _digitRegExp.stringMatch(character) != null;
}
