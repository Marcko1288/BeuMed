import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {super.key,
      required this.text_labol,
      required this.text_default,
      this.secure = false,
      this.actionText = TextInputAction.next,
      List<String>? autofill,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.decoration = TypeDecoration.labolBord,
      List<TypeValidator>? listValidator,
      this.limit_char = 99,
      required this.onStringChanged })
      : this.autofill = autofill ?? [],
        this.listValidator = listValidator ?? [];

  ///Testo da mostrare come sfondo
  String text_default;

  ///Testo da mostrare come sfondo
  String text_labol;
  //String modify_text;

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
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: widget.text_default,
        enabled: widget.enabled,
        textInputAction: widget.actionText,
        obscureText: widget.secure,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autofill,
        decoration: InputDecoration(
          labelText: widget.text_labol,
          focusedBorder: defaultBorder(master.theme(size).primaryColor),
          enabledBorder: defaultBorder(master.theme(size).primaryColor),
          disabledBorder: defaultBorder(master.theme(size).primaryColor),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.limit_char),
        ],
        onChanged: (String value) {
          setState(() {
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
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    switch (this) {
      case TypeDecoration.focusBord:
        return InputDecoration(
            hintText: value,
            border: defaultBorder(master.theme(size).primaryColor),
        );
      case TypeDecoration.labolBord:
        return InputDecoration(
          border: defaultBorder(master.theme(size).primaryColor),
          labelText: value,
        );
    }
  }
}

OutlineInputBorder defaultBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: color),
  );
}
