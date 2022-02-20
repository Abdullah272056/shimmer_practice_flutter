import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer_practice_flutter/third_page.dart';

import 'ApiListTest.dart';
import 'fourth.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _isObscure = true;

  String BASE_URL_API = "http://13.52.81.125:8000/api/";
  String SUB_URL_API = "v1/user-login/";

  TextEditingController? otpEditTextController = new TextEditingController();
  String _otpTxt = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.backGroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
             // Navigator.pop(context, true);
            },
          ),
          title: const Text("Second Page"),
          backgroundColor: Colors.appRed,
          automaticallyImplyLeading: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [

                  // Image.asset('assets/images/profile.jpg'),
                  const Text(
                    "let's Discover Bangladesh Together",
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  // Image.asset('assets/images/profile.jpg'),
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 30,
                  ),


                  _buildLoginButton(),
                  SizedBox(height: 40,),
                  _buildLoginButton1(),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    // passwordController=TextEditingController(text:SharedPref().readUserId());
  }



  Widget _buildLoginButton1() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.appRed,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
        child: const Text(
          'Four',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        onPressed: () {

          Navigator.push(context,MaterialPageRoute(builder: (context)=>FourPageScreen()));
        },
      ),
    );
  }
  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.appRed,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ),
        child: const Text(
          'Second',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        onPressed: () {

          Navigator.push(context,MaterialPageRoute(builder: (context)=>ApiTestPageScreen()));
        },
      ),
    );
  }

}
