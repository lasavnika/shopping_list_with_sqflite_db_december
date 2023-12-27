import 'package:flutter/material.dart';
import 'package:shopping_list_with_sqflite_db_december/database/database.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/contract/user_repo_contract.dart';
import 'package:shopping_list_with_sqflite_db_december/database/repositories/user_repo.dart';
import 'package:shopping_list_with_sqflite_db_december/models/user_model.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/Auth/sign_up_screen.dart';
import 'package:shopping_list_with_sqflite_db_december/screens/first_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  final UserRepoContract userRepo = UserRepo();

  bool isVisible = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper.init();

  login() async {
    int? response = await userRepo
        .getUserId(Users(userName: username.text, userPassword: password.text));
    if (response != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstScreen(
            userId: response,
          ),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = false;
      });
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('lib/assets/images/branch_tree.jpg'),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 181, 63, 140),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 181, 63, 140),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User name is required!";
                        } else {
                          username.text = value;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 181, 63, 140),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User password is required!";
                        } else {
                          password.text = value;
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 181, 63, 140)),
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do not have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
                isLoginTrue
                    ? const Text(
                        'Username or password is incorrect',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
