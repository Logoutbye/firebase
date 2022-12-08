import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseeurraannew/phone_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var firebase_auth= FirebaseAuth.instance;
  bool isCodeSent= false;


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                )
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                )

            ),
            Row(
              children: [

                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        String email = emailController.text.toString();
                        String password = passwordController.text.toString();

                        try{
                          firebase_auth.createUserWithEmailAndPassword(
                              email: email, password: password).then((UserCredential user_credentials){
                            print("object ${user_credentials.user.toString()}");
                            print("object ${user_credentials.credential!.signInMethod}");
                            print("object ${user_credentials.credential!.token}");

                          }).onError((FirebaseAuthException error, stackTrace) {
                            if (error.code == "email-already-in-use"){
                              print("The email address is already in use by another account");
                            }
                          });
                        }catch(e){
                          print("database error${e.toString()}");
                          return;
                        }
                      },
                      child: Text("SignUP",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                    )
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        String email = emailController.text.toString();
                        String password = passwordController.text.toString();

                        try{
                          firebase_auth.signInWithEmailAndPassword(
                              email: email, password: password).then((UserCredential user_credentials){
                            print("object ${user_credentials.user.toString()}");
                            print("object ${user_credentials.credential?.signInMethod.toString()}");
                            print("object ${user_credentials.credential!.token.toString()}");

                          }).onError((FirebaseAuthException error, stackTrace) {
                            if(error.code =="wrong-password" ){
                              print("The password is invalid or the user does not have a password.");

                            }
                          });
                        }catch(e){
                          print("database error${e.toString()}");
                          return;
                        }
                      },
                      child: Text("SignIn",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                    )
                ),
              ],
            ),

            Row(
              children: [

                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {

                        try{
                          firebase_auth.signInAnonymously().then((value){
                            print("object ${firebase_auth.currentUser.toString()}");

                          }).onError((FirebaseAuthException error, stackTrace) {
                            if (error.code == "email-already-in-use"){
                              print("The email address is already in use by another account");
                            }
                          });
                        }catch(e){
                          print("database error${e.toString()}");
                          return;
                        }
                      },
                      child: Text("Anonymous",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                    )
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        try{
                          firebase_auth.signOut().then((value){
                            print("object ${firebase_auth.currentUser.toString()}");

                          }).onError((FirebaseAuthException error, stackTrace) {
                            if (error.code == "email-already-in-use"){
                              print("The email address is already in use by another account");
                            }
                          });
                        }catch(e){
                          print("database error${e.toString()}");
                          return;
                        }
                      },
                      child: Text("SignOut",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                    )
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      onPressed: () {
                        try{
                          print("${firebase_auth.currentUser.toString()}");
                        }catch(e){
                          print("database error${e.toString()}");
                          return;
                        }
                      },
                      child: Text("CurrentUser",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                    )
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: ElevatedButton(
                        child: const Text('Open route'),onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhoneLogin()),
                      );
                    }
                    ),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}

