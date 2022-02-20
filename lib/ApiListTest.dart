import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

class ApiTestPageScreen extends StatefulWidget {
  const ApiTestPageScreen({Key? key}) : super(key: key);
  @override
  State<ApiTestPageScreen> createState() => _ApiTestPageScreenState();
}

class _ApiTestPageScreenState extends State<ApiTestPageScreen> {
  var data;
  // Future getData ()async{
  //
  //   var response=await get(
  //     Uri.parse('https://reqres.in/api/users?page=2'),
  //   );
  //   setState(() {
  //     var decode= jsonDecode(response.body.toString());
  //     data=decode["data"];
  //     print(data);
  //   });
  //
  // }

  bool shimmerStatus=true;
   int dataListLength=0;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    //getData();
    _getData();
    // passwordController=TextEditingController(text:SharedPref().readUserId());
  }

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
              // Navigator.pop(context,true);
            },
          ),
          title: const Text("Checkout"),
          backgroundColor: Colors.appRed,
          automaticallyImplyLeading: true,
        ),
        body:Column(
          children: [
            if(shimmerStatus)...[
              Expanded(child:  ListView.builder(
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        margin: new EdgeInsets.only(left: 10,right: 1,top: 5,),
                        width: 50,
                        height: 60,
                        color: Colors.blueGrey,
                      ),
                      Expanded(child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Shimmer.fromColors(
                            baseColor: Colors.blueGrey,
                            highlightColor: Colors.hint_color,
                            child: Container(
                              margin: new EdgeInsets.only(left: 10,right: 10),
                              color: Colors.blueGrey,
                              child: Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),

                          ),
                          SizedBox(height: 5,),
                          Shimmer.fromColors(
                            baseColor: Colors.blueGrey,
                            highlightColor: Colors.hint_color,
                            child: Container(
                              margin: new EdgeInsets.only(left: 10,right: 10),
                              color: Colors.blueGrey,
                              child: Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        ],
                      ))

                    ],
                  );
                },
              ),),
            ]else...[
              if(dataListLength>0)...[
                Expanded(child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.network(
                          data[index]["avatar"],
                          width: 50,
                          height: 70,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              data[index]["first_name"],
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 3,
                            ),

                            Text(
                              data[index]["email"],
                              style: TextStyle(fontSize: 15),
                            ),


                            SizedBox(
                              height:5,
                            ),

                          ],
                        )
                      ],
                    );
                  },
                ),)
              ]else...[
                Expanded(child: Center(
                  child: Text("No data found!"),
                ))
              ]



            ]
          ],
        )
      ),
    );
  }

  _getData() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');

        try {
          var response = await get(
           Uri.parse('https://reqres.in/api/users?page=2d'),
           // Uri.parse('https://reqresds.in/api/qweusers?page=2d'),
          );

          if (response.statusCode == 200) {
            setState(() {
              var decode = jsonDecode(response.body.toString());
              data = decode["data"];
              dataListLength=data.length;
              shimmerStatus=false;
              print(data);
            });
          }
          else {

            _showToast("failed");
          }
        } catch (e) {


          _showToast("failed");
          setState(() {


          });
        }
      }
    } on SocketException catch (_) {}
  }


  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey,
      highlightColor: Colors.hint_color,
      child: Container(
          color: Colors.white,
          height: 50,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
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
              );


            },
          ),
      ),
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
