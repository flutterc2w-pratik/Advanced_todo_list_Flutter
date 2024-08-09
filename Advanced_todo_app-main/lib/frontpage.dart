import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginpage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});
  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 100)),
            //  const SizedBox(height: 10,),
            Image.asset(
              "assets/images/welcome.jpg",
              height: 255,
              width: 350,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 15),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 420,
                        child: Text(
                          "Manage and organize all",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700, fontSize: 28),
                        )),
                    SizedBox(
                        width: 420,
                        child: Text(
                          "your tasks",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(13, 26, 211, 0.557),
                                shadows: [
                                  Shadow(
                                      color: Colors.grey,
                                      blurRadius: 20,
                                      offset: Offset(5, 5))
                                ]),
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                        width: 420,
                        child: Text(
                          "Increase your productivity by organizing daily task and making scheduled reminders",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 45),
                  backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ));
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
