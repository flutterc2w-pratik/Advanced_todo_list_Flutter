import 'package:flutter/material.dart';
import 'package:flutter_advanedtodo/todo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool ispassed = false;
  String userName = '';
  String pass = '';

  String nameval = "pranjal123@gmail.com";
  String passval = "Pranjal123";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
            const   Padding(padding: EdgeInsets.only(top: 60)),
              Image.asset(
                "assets/images/loginpage.png",
                width: 210,
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: usernamecontroller,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter Username',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: !ispassed,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispassed = !ispassed;
                                  });
                                },
                                icon: const Icon(Icons.visibility_off_rounded)),
                            hintText: 'Enter Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter  password';
                            } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
                              return 'Password must starts with capital letter';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(89, 57, 241, 1),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(89, 57, 241, 1)),
                        onPressed: () {
                          userName = usernamecontroller.text;
                          pass = passwordcontroller.text;
                          bool validated = _formkey.currentState!.validate();
                          if (validated) {
                            if (userName == nameval && passval == pass) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  duration: Durations.extralong4,
                                  content: Text(
                                    "Logged Successfully!",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const FinalTodo();
                                },
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Durations.extralong4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  content: Text(
                                    "Login failed please enter valid information (:",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "or Login with",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/images/apple.jpg",
                    height: 35,
                    width: 35,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color.fromRGBO(89, 57, 241, 1)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
