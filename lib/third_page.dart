import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';



class ThirdPageScreen extends StatefulWidget {
  const ThirdPageScreen({Key? key}) : super(key: key);
  @override
  State<ThirdPageScreen> createState() => _ThirdPageScreenState();
}

class _ThirdPageScreenState extends State<ThirdPageScreen> {
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
        body: ListView.builder(
          itemCount: dataList == null ? 0 : dataList.length,
          itemBuilder: (context, index) {
            return Text(
              dataList[index]["userId"],
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 1,
            );


            // _buildCartListItem(cartDataList[index]);
          },
        )
      ),
    );
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _getDataList();
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
