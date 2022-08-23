import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(),
          const Center(
            child: SizedBox(
              // color: Colors.red,
              height: 70,
              // child: Image.asset("assets/images/clivy_logo.png")
              child: Text(
                "Happ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w800
                )
              )
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              context.push('/sign_up');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 45,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 75, 207, 255),
                borderRadius: BorderRadius.circular(25),
                // border: Border.all(color: Color.fromARGB(255, 56, 172, 255), width: 2.0),
              ),
              child: const Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1
                  )
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push('/sign_in');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.transparent,
              height: 45,
              child: const Center(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Color.fromARGB(255, 75, 210, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1
                  )
                ),
              )
            ),
          ),
          const SizedBox(
            height: 30
          )
        ],
      )
    );
  }
}