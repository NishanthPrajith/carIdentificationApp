// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  final VoidCallback showsignuppage;
  const SigninPage({Key? key, required this.showsignuppage}) : super(key: key);
  
  @override
  State<SigninPage> createState() => _SigninPage();
}

class _SigninPage extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int error = 0;

  String errorMessage = "";
  

  Future SignIn() async {
    if (_emailController.text.trim() == "" || _passwordController.text.trim() == "") {
      setState(() {
        error = 1;
      });
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          );
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = 2;
          var temp = "";
          var check = true;
          for (var i = 0; i < e.code.length; i++) {
            if (e.code[i] == "-") {
              temp += " ";
              check = true;
            } else {
              if (check) {
                temp += e.code[i].toUpperCase();
                check = false;
              } else {
                temp += e.code[i];
              }
            }
          }
          errorMessage = temp;
        });
      }
    }
  }

  @override 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // Hello again 
                const Text(
                  'Hello again',
                  style: TextStyle (
                    fontWeight: FontWeight.bold,
                    fontSize: 32,),),
                const SizedBox(height: 10),
                const Text(
                  'Sign in below',
                  style: TextStyle (
                    fontSize: 16,),
                    ),
                    const SizedBox(height: 50),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            ),
                        // email Text
        
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: true,
                            decoration: const InputDecoration(
                              border:  InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 15),
                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        obscureText : true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border:  InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                
                error == 1 ? const Text(
                  "Please fill in all fields",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ) : const SizedBox(height: 0),
                error == 2 ? Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ) : const SizedBox(height: 0),

                const SizedBox(height: 40),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: SignIn,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                      child:  const Center(
                        child:  Text('Sign In',
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',
                    ),
                    GestureDetector(
                      onTap: widget.showsignuppage,
                      child: const Text(
                        ' Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}