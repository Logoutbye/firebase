import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {

  var PhoneController = TextEditingController();

  var CodeController = TextEditingController();

  var firebase_auth= FirebaseAuth.instance;
  String VerificationId ="";

  bool isCodeSent= false;


  PhoneNumberAuthCompleted(BuildContext context,String code_sms){
    PhoneAuthCredential credential =PhoneAuthProvider.credential
      (verificationId: VerificationId,
        smsCode: code_sms);
    firebase_auth.signInWithCredential(credential).then((UserCredential userCredentials) {
      print("object${userCredentials.user.toString()}");
    });
  }
  @override
  void initState() {
    super.initState();
  }
  VerifyPhoneNumber(BuildContext context) async{
    String PhoneNo = PhoneController.text.toString();
    try{

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: PhoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          this.VerificationId = credential.verificationId!;
          setState(() {
            CodeController.text= credential.smsCode!;
          });
          print("hello firease verification completed ${credential.smsCode}");
          PhoneNumberAuthCompleted(context,credential.smsCode!);

        },
        verificationFailed: (FirebaseAuthException e) {
          print("hello firease verification failed${e.toString()} }");

        },
        codeSent: (String verificationId, int? resendToken) {
          this.VerificationId = verificationId;
          setState(() {
            isCodeSent= true;
          });
          print("hello firease codeSent }");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.VerificationId = verificationId;
          print("hello firease codeAutoRetrievalTimeout }");
        },
      );
    } on FirebaseAuthException catch (error,_){
      print("hello fireaseAuthException ${error.toString()} }");
    } catch(e){
      print("hello fireaseAuthException ${e.toString()} }");
    }
  }


  @override
  Widget build(BuildContext context) {
    GestureTapCallback  onTapVerify=() {
      if (!isCodeSent) {
        VerifyPhoneNumber(context);
      } else {
        String code_sms = CodeController.text.toString();
        PhoneNumberAuthCompleted(context,code_sms);
      }
    };


    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                     Padding(
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter number"
                                ,enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              controller: PhoneController,
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Password"
                                ,enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              ),
                              controller: CodeController,
                            ),
                          )

                      ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: ElevatedButton(
                  onPressed:onTapVerify,
    child:  Text(isCodeSent? "Verify Code": "Verify Phone Number"),

              ),
            ),
          ),
        ],
      ),
      

    );

  }
}

