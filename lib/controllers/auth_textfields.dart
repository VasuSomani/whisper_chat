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
  TextFieldEmail(this.controller, {super.key});
  final TextEditingController controller;

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
          decoration: InputDecoration(
            hintText: "Enter your e-mail here",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: Icon(Icons.alternate_email_rounded),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
          ),
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
  TextFieldPass(this.controller);
  final TextEditingController controller;

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
          decoration: InputDecoration(
            hintText: "Enter your password here",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: Icon(Icons.lock_rounded),
            suffixIconColor: Colors.grey,
            suffixIcon: IconButton(
              icon: (isObscure)
                  ? const Icon(
                      CupertinoIcons.eye_slash,
                    )
                  : const Icon(CupertinoIcons.eye),
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
  TextFieldConfirmPass(this.controller, this.password);
  final TextEditingController controller;
  final TextEditingController password;

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
          decoration: InputDecoration(
            hintText: "Enter your password again",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: Icon(Icons.lock_rounded),
            filled: true,
            fillColor: textFieldBg,
            focusedErrorBorder: errorBorder,
            errorBorder: errorBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
          ),
          obscureText: true,
          validator: (value) {
            if (value != password.text) {
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
  TextFieldUserName(this.controller);
  final TextEditingController controller;

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

  Future userNameValidation(String? value) async {
    querySnapshot =
        await db.collection('users').where('userName', isEqualTo: value).get();

    if (value == null || value.trim().isEmpty) {
      setState(() {
        validationError = "Username can't be empty";
        isValidated = false;
      });
    } else if (!isSnakeCase(value)) {
      setState(() {
        validationError = "Username must be in snake_case";
        isValidated = false;
      });
    } else if (querySnapshot == null) {
      setState(() {
        validationError = null;
        isValidated = true;
      });
    } else if (querySnapshot!.docs.isNotEmpty) {
      setState(() {
        validationError = "Username already exists";
        isValidated = false;
      });
    } else {
      setState(() {
        validationError = null;
        isValidated = true;
      });
    }
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
          maxLength: 15,
          decoration: InputDecoration(
            hintText: "Enter user name",
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon: Icon(Icons.person_rounded),
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
            return validationError;
          },
        ),
      ],
    );
  }
}
