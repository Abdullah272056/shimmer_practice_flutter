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



  TextEditingController? otpEditTextController = new TextEditingController();
  String _otpTxt = "";

  var dataList;
  var dataListCopy;
   late List<String> filterDataList;

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
        body:Column(
          children: [
            InkResponse(
              child: Text("Filter",
              style: TextStyle(
                fontSize: 30,

              ),),
              onTap: (){
                for(int i=0;i<dataList.length; i++){

                 //_showToast(filterDataList.length.toString());
                  if(dataList[i]["userId"].toString()=="1"){

                    dataListCopy[i]=dataList[i];
                   // filterDataList.add(dataList[i]["id"].toString());
                   // _showToast(filterDataList.length.toString());
                  }
                }
               _showToast(dataListCopy.length.toString());
              },
            ),

            Expanded(child:
            ListView.builder(
              itemCount: dataList == null ? 0 : dataList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [

                    Container(
                      margin: new EdgeInsets.only(left: 10,right: 1,top: 5,),
                      color: Colors.blueGrey,
                      child:Flex(
                        direction: Axis.horizontal,
                        children: [
                         Expanded(child:Container(
                           margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                           child:  Column(

                             children: [
                               Text(
                                 dataList[index]["id"].toString(),
                                 style: const TextStyle(
                                     fontSize: 22, fontWeight: FontWeight.w600),
                                 maxLines: 1,
                               ),

                               Text(
                                 dataList[index]["title"].toString(),
                                 style: const TextStyle(
                                     fontSize: 18, fontWeight: FontWeight.w600),
                                 maxLines: 2,
                               ),

                             ],

                           ),
                         ),

                        )
                        ],
                      ) ,


                    ),
                  ],

                );
              },
            )
            )
          ],
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
            setState(() {
              _showToast("success");
              dataList = jsonDecode(response.body);
            });


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
