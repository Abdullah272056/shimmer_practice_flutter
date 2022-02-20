import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';



class FourPageScreen extends StatefulWidget {
  const FourPageScreen({Key? key}) : super(key: key);
  @override
  State<FourPageScreen> createState() => _FourPageScreenState();
}

class _FourPageScreenState extends State<FourPageScreen> {
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _isObscure = true;

  String BASE_URL_API = "http://13.52.81.125:8000/api/";
  String SUB_URL_API = "v1/user-login/";

  TextEditingController? otpEditTextController = new TextEditingController();
  String _otpTxt = "";

  var dataList;

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
              Navigator.pop(context, true);
            },
          ),
          title: const Text("Second Page"),
          backgroundColor: Colors.appRed,
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child:Column(
              children: [

                SizedBox(
                  height: 100,
                ),
                Shimmer.fromColors(child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.amberAccent,
                      )
                    ],
                  ),

                ),
                    baseColor: Colors.black, highlightColor:Colors.hint_color ),
                SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.black,
                    child: Text(
                      'Shimmer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.green,
                  highlightColor: Colors.red,
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.green,
                  highlightColor: Colors.red,
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  child: Text("Go To",style: TextStyle(fontSize: 25),),
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                  },
                ),
              ],
            )



        ),
      ),
    );
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
   // _getDataList();
    // passwordController=TextEditingController(text:SharedPref().readUserId());
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
          'LOG IN',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        onPressed: () {

         // Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
        },
      ),
    );
  }

  _getDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _showLoadingDialog(context);
        try {
          var response = await get(
            Uri.parse('https://jsonplaceholder.typicode.com/todos'),
          );
         Navigator.of(context).pop();

          if (response.statusCode == 200) {
            _showToast("success");
            dataList = jsonDecode(response.body);
            _showToast(dataList.length.toString());

          } else {

            _showToast("failed");
          }
        } catch (e) {
          Fluttertoast.cancel();
          print(e.toString());
          _showToast("Failed");
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Wrap(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20, bottom: 20),
                  child: Center(
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: Colors.appRed,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Loading...",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ))
            ],
            // child: VerificationScreen(),
          ),
        );
      },
    );
  }
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
