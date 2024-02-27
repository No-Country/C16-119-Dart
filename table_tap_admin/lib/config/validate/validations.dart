class Validate {
  bool validateIsVacio(String text) {
    if (text.isEmpty) {
      return true;
    }
    return false;
  }

  bool validateIsLengthMin(String text, int sizeCharacterMin) {
    if (text.length > sizeCharacterMin) {
      return true;
    }
    return false;
  }

  bool validateIsLengthMax(String text, int sizeCharacterMin) {
    if (text.length < sizeCharacterMin) {
      return true;
    }
    return false;
  }

  bool validateDomainEmail(String text) {
    if (text.contains('@gmail.com')) {
      return true;
    }
    return false;
  }

  bool validateIsExpresion(String text, RegExp expresion) {
    if (expresion.hasMatch(text)) {
      return true;
    }
    return false;
  }

  String validateIsTextEmpity(String text,) {
    if (text.isEmpty) {
      return "Este campo es requerido..";
    }
    return '';
  }
}
