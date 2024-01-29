import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:beumed/Library/Extension_String.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {super.key,
      required this.text,
      required this.modify_text,
      this.secure = false,
      this.actionText = TextInputAction.next,
      List<String>? autofill,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.decoration = TypeDecoration.labolBord,
      List<TypeValidator>? listValidator,
      this.limit_char = 99,
      required this.onStringChanged})
      : this.autofill = autofill ?? [],
        this.listValidator = listValidator ?? [];

  String text;

  ///Testo da mostrare come sfondo
  String modify_text;

  ///Testo digitato
  bool secure;

  ///Nascondere/Mostrare i dati inseriti
  TextInputAction actionText;

  ///Azione da effettuare dopo l'inserimento del testo
  List<String> autofill;

  ///Autocompletamento
  TextInputType keyboardType; //Tipologia di tastiera da mostrare
  bool enabled;

  ///Abilitare/Disabilitare il TextField
  TypeDecoration decoration;

  List<TypeValidator> listValidator;

  int limit_char;

  ///La lista delle validazioni da effetture

  final ValueChanged<String> onStringChanged;

  ///Esportare il valore inserito

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: size.width * 0.4,
        child: TextFormField(
          textInputAction: widget.actionText,
          obscureText: widget.secure,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          autofillHints: widget.autofill,
          enabled: widget.enabled,
          decoration: widget.decoration.value(context, widget.text),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.limit_char),
          ],
          onChanged: (String value) {
            setState(() {
              //widget.text = value;
              widget.onStringChanged(value);
            });
          },
          validator: FormBuilderValidators.compose([
            for (var element in widget.listValidator)
              element == TypeValidator.cf
                  ? (valid) => valid.toString().isCF
                      ? null
                      : "Codice Fiscele non valido!"
                  : element == TypeValidator.piva
                      ? (valid) => valid.toString().isCF
                          ? null
                          : "Codice Fiscele non val"
                      : element.value,
          ]),
        ),
      ),
    );
  }
}

extension ExtFBVali on FormBuilderValidators {
  static FormFieldValidator<String> cf({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isCF
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;

  static FormFieldValidator<String> pippo({
    String? errorText,
  }) =>
      (valueCandidate) => true == valueCandidate?.isPIVA
          ? errorText ?? FormBuilderLocalizations.current.numericErrorText
          : null;
}

enum TypeValidator {
  required,
  email,
  number,
  min,
  max,
  minLenght,
  maxLenght,
  cf,
  piva,
}

extension ExtTypeValidator on TypeValidator {
  dynamic get value {
    switch (this) {
      case TypeValidator.required:
        return FormBuilderValidators.required(errorText: 'Campo Obbligatorio');
      case TypeValidator.email:
        return FormBuilderValidators.email(
            errorText: 'Formato mail non valido');
      case TypeValidator.number:
        return FormBuilderValidators.numeric(
            errorText: 'Formato non corretto, inserire un valore [0-9]');
      case TypeValidator.min:
        return FormBuilderValidators.min(1,
            errorText: 'Inserire almeno un valore');
      case TypeValidator.max:
        return FormBuilderValidators.max(10000000,
            errorText: 'Valore inserito troppo alto');
      case TypeValidator.minLenght:
        return FormBuilderValidators.minLength(1,
            errorText:
                'Inserire almeno un valore, il campo non può essere vuoto');
      case TypeValidator.maxLenght:
        return FormBuilderValidators.maxLength(10000,
            errorText: 'Valore troppo grande, inserire un valore più piccolo');
      case TypeValidator.cf:
        return null; //FormBuilderValidators.cf(errorText: 'Codice Fiscale non valido');
      case TypeValidator.piva:
        return null;
    }
  }
}

enum TypeDecoration { focusBord, labolBord }

extension ExtTypeDecoration on TypeDecoration {
  dynamic value(BuildContext context, String value) {
    switch (this) {
      case TypeDecoration.focusBord:
        return InputDecoration(
            hintText: value,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).primaryColor)));
      case TypeDecoration.labolBord:
        return InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: value,
        );
    }
  }
}
