import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/colors.dart';

OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Color(0xFFE5E6EE)));

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: Colors.red));

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(color: primaryColor, width: 1));

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail(this.controller,
      {this.enableValidation = false, super.key});
  final TextEditingController controller;
  final bool enableValidation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            "E-mail",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          autovalidateMode: (enableValidation)
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          decoration: InputDecoration(
            hintText: "Enter your e-mail here",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: const Icon(Icons.alternate_email_rounded),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
          ),
          enableSuggestions: true,
          validator: (value) {
            if (value == null ||
                value.trim() == "" ||
                value.trim().length < 3 ||
                !value.contains("@")) {
              return "Enter a valid email address";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TextFieldPass extends StatefulWidget {
  const TextFieldPass(this.controller,
      {super.key, this.enableValidation = false});
  final TextEditingController controller;
  final bool enableValidation;

  @override
  State<TextFieldPass> createState() => _TextFieldPassState();
}

class _TextFieldPassState extends State<TextFieldPass> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            "Password",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextFormField(
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          autovalidateMode: (widget.enableValidation)
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          decoration: InputDecoration(
            hintText: "Enter your password here",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: const Icon(Icons.lock_rounded),
            suffixIconColor: Colors.grey,
            suffixIcon: IconButton(
              icon: (isObscure)
                  ? const Icon(
                      CupertinoIcons.eye_slash_fill,
                    )
                  : const Icon(CupertinoIcons.eye_fill),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorMaxLines: 2,
          ),
          obscureText: isObscure,
          validator: (value) {
            if (value == null || value.contains(" ")) {
              return "Password can't be empty";
            } else if (value.trim().length < 6) {
              return "Password should be atleast 6 characters long";
            } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[^\w\s]).*$')
                .hasMatch(value)) {
              return "Password should be a combination of capital, small, integer, and special characters";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TextFieldConfirmPass extends StatelessWidget {
  const TextFieldConfirmPass(this.controller, this.password,
      {super.key, this.enableValidation = false});
  final TextEditingController controller;
  final TextEditingController password;
  final bool enableValidation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            "Confirm Password",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          autovalidateMode: (enableValidation)
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          decoration: InputDecoration(
            hintText: "Enter your password again",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: const Icon(Icons.lock_rounded),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.trim() == "") {
              return "Confirm Password can't be empty";
            } else if (value != password.text) {
              return "Confirm Password must be same as Password";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TextFieldUserName extends StatefulWidget {
  const TextFieldUserName(this.controller,
      {super.key, this.enableValidation = false});
  final TextEditingController controller;
  final bool enableValidation;

  @override
  State<TextFieldUserName> createState() => _TextFieldUserNameState();
}

class _TextFieldUserNameState extends State<TextFieldUserName> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot? querySnapshot;
  String? validationError;
  bool isValidated = false;
  bool isSnakeCase(String text) {
    final regex = RegExp(r'^[a-z]+(?:_[a-z]+)*$');
    return regex.hasMatch(text);
  }

  void userNameValidation(String value) {
    if (value == null || value.trim().isEmpty) {
      updateValidation(null, false);
    } else if (!isSnakeCase(value)) {
      updateValidation("Username must be in snake_case", false);
    } else {
      db.collection('users').where('userName', isEqualTo: value).get().then(
        (snapshot) {
          if (snapshot.docs.isNotEmpty) {
            updateValidation("Username already exists", false);
          } else {
            updateValidation(null, true);
          }
        },
      );
    }
  }

  void updateValidation(String? error, bool validated) {
    setState(() {
      validationError = error;
      isValidated = validated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            "User Name",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextFormField(
          controller: widget.controller,
          textInputAction: TextInputAction.next,
          autovalidateMode: (widget.enableValidation)
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          maxLength: 15,
          decoration: InputDecoration(
            hintText: "Enter user name",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: const Icon(Icons.person_rounded),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            suffixIcon: Icon(
              Icons.check_circle,
              size: 20,
              color: isValidated ? Colors.green : Colors.grey,
            ),
          ),
          onChanged: (value) {
            userNameValidation(value);
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Username can't be empty";
            } else if (!isSnakeCase(value)) {
              return "Username must be in snake_case";
            } else if (!isValidated) {
              return validationError;
            }
            return null;
          },
        ),
      ],
    );
  }
}
