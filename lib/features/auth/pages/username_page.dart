import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ytclone/cores/widgets/flat_button.dart';
import 'package:ytclone/features/auth/repository/user_data_service.dart';

final fromKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String email;
  final String profilePic;
  const UsernamePage({
    required this.displayName,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  bool isValidate = true;
  void validateUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection("users").get();
    final users = usersMap.docs.map((user) => user).toList();
    String? targetedUsername;

    for (var user in users) {
      if (usernameController.text == user.data()["username"]) {
        targetedUsername = user.data()["username"];
        isValidate = false;
        setState(() {});
      }
      if (usernameController.text != targetedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 26,
                horizontal: 14,
              ),
              child: Text(
                "Enter the username",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Form(
                child: TextFormField(
                  onChanged: (username) {
                    validateUsername();
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (username) {
                    return isValidate ? null : "Username already taken!";
                  },
                  key: fromKey,
                  controller: usernameController,
                  decoration: InputDecoration(
                    suffixIcon: isValidate
                        ? Icon(Icons.verified_user_rounded)
                        : Icon(Icons.cancel),
                    suffixIconColor: isValidate ? Colors.green : Colors.red,
                    hintText: "Insert username",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 8),
              child: FlatButton(
                text: "CONTINUE",
                onPressed: () async {
                  //add users data inside database
                  isValidate ? await ref
                      .read(userDataServiceProvider)
                      .addUserDataToFirestore(
                        displayName: widget.displayName,
                        username: usernameController.text,
                        email: widget.email,
                        profilePic: widget.profilePic,
                        descriptions: "",
                      ) : null;
                },
                colour: isValidate ? Colors.green : Colors.green.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
