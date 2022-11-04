// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  final VoidCallback showaccountPage;
  const signup({Key? key, required this.showaccountPage}) : super(key: key);
  
  @override
  State<signup> createState() => _signup();
}
  
class _signup extends State<signup> {
  final _nameController = TextEditingController();
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
  
  Future SignUp() async {
    if (_nameController.text.trim() == "" || _emailController.text.trim() == "" || _passwordController.text.trim() == "") {
      setState(() {
        error = 1;
      });
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text.trim())) {
      setState(() {
        error = 2;
      });
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(), 
          password: _passwordController.text.trim(),);
        await FirebaseAuth.instance.currentUser!.updateDisplayName(_nameController.text.trim());
        await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({
          'saved': [],
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          error = 3;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // Hello again 
                  const Text(
                    'Welcome',
                    style: TextStyle (
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 10),
          
                  const Text(
                    'Sign up below',
                    style: TextStyle (
                      fontSize: 16,
                    ),
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
                      // profile name Text
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border:  InputBorder.none,
                            hintText: 'Profile name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
              
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
                          keyboardType: TextInputType.text,
                          controller: _emailController,
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
                        child: TextFormField(
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
                  error == 2 ? const Text(
                    "Please enter a valid email",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ) : const SizedBox(height: 0),
                  error == 3 ? Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ) : const SizedBox(height: 0),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: SignUp,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child:  const Center(
                          child:  Text('Sign Up',
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
                      const Text('Already have an account?'),
                      GestureDetector(
                        onTap: widget.showaccountPage,
                        child: const Text(
                          ' Sign in',
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
      ),
    );
  }
}