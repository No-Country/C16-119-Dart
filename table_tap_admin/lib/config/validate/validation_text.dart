import 'package:table_tap_admin/config/validate/validations.dart';
import '../erros/form_errors.dart';

class ValidationTextForm {
  Validate validate = Validate();
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp passwordLowerAndUpperValidatorRegExp =
      RegExp(r"^(?=.*[a-z])(?=.*[A-Z]).*$");
  final RegExp passwordNumericValidatorRegExp = RegExp(r"^(?=.*\d).*$");
  final RegExp passwordSpecialCharacterValidatorRegExp =
      RegExp(r"^(?=.*[!@#\$&*~]).*$");

  String? validateEmail(String text) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kEmailNullError;
    } else if (!validate.validateIsExpresion(text, emailValidatorRegExp)) {
      return FormErrors.kEmailInvalidError;
    } else if (!validate.validateDomainEmail(text)) {
      return FormErrors.kEmailDomainError;
    }
    return null;
  }

  String? validatePassword(String text) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kPassNullError;
    } else if (!validate.validateIsLengthMin(text, 8)) {
      return FormErrors.kPassShortError;
    } else if (!validate.validateIsExpresion(
        text, passwordLowerAndUpperValidatorRegExp)) {
      return FormErrors.kPassAlpaLowerAndUpperError;
    } else if (!validate.validateIsExpresion(
        text, passwordNumericValidatorRegExp)) {
      return FormErrors.kPassNumericError;
    } else if (!validate.validateIsExpresion(
        text, passwordSpecialCharacterValidatorRegExp)) {
      return FormErrors.kPassCharacterSpecialsError;
    }
    return null;
  }

  String? validatePasswordConfirmation(String text, String textConfirmation) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kPassConfirmationNullError;
    } else if (text != textConfirmation) {
      return FormErrors.kPassConfirmationEqualPassError;
    }
    return null;
  }

  String? validateName(String text) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kNamelNullError;
    }
    return null;
  }

  String? validateLastName(String text) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kLastNamelNullError;
    }
    return null;
  }

  String? validatePhoneNumber(String text) {
    if (validate.validateIsVacio(text)) {
      return FormErrors.kPhonelNullError;
    } else if (!validate.validateIsExpresion(
        text, passwordNumericValidatorRegExp)) {
      return FormErrors.kPhoneNumberNullError;
    }
    return null;
  }


  String? validateIsTextEmpity(String text,) {
    if (text.isEmpty) {
      return "Este campo es requerido..";
    }
    return null;
  }

}
