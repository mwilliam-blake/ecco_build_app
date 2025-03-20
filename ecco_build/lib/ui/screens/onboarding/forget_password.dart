import 'dart:convert';

import 'package:ecco_build/ui/screens/onboarding/home.dart';
import 'package:ecco_build/ui/screens/onboarding/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dashboard.dart';

class forget_password extends StatefulWidget {

  @override
  State<forget_password> createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  bool isloading = false;
  Future<void> forget_paswrd(String email,context) async {


    if(email=='') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
        Text("Please enter your Email Address"), behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
    }
    else {
      setState(() {
        isloading=true;
      });
      /* Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: CircularProgressIndicator()))
      ); */
      try {
        Response response = await post(
            Uri.parse('http://ecco.mob-api.pro-sps.com/api/forgot-password'),
            body: {
              'email': email,
            }
        );
        setState(() {
          isloading = false;
        });
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text("Password has been sent to your email. Please check your Email."),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => homepage()));

          ///print(data['token']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text("Invalid E-mail. Please try with your registered Email ID"),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
          Text(e.toString()),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    const IconData person_add_alt_1_sharp = IconData(0xeb88, fontFamily: 'MaterialIcons');
    TextEditingController unameController = TextEditingController();
    TextEditingController pwordController = TextEditingController();

    return isloading==true ? Center(child:  CircularProgressIndicator(),
        ) : GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body:
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/Login_bg.png"),fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Image.asset("assets/images/build_logo.png", width: 200, height: 150,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                        child: Column(
                          children: [
                            Text("Forget Password", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,),),

                            SizedBox(height: 30,),
                            Align(alignment:Alignment.centerLeft, child: Text("Email", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                            TextField(
                              controller: unameController,
                              decoration: InputDecoration(
                                hintText: "Enter your Email ID",
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(11)),
                                    borderSide: BorderSide(
                                      color: Color(0xffdfd3d3),
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(11)),
                                    borderSide: BorderSide(
                                      color: Color(0xffdfd3d3),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(11.0),
                                  ),
                                ),
                                onPressed: () {
                                  forget_paswrd(unameController.text.toString(),context);
                                },
                                child: Text(" Submit ", style: TextStyle(color: Colors.white, fontSize: 20),),),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("     ",style: TextStyle(fontSize: 15, color: Colors.grey,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                                InkWell(onTap: () {
                                  Navigator.pop(context);
                                }, child: Text("Back to login ",style: TextStyle(fontSize: 15, color: Colors.blueAccent,fontWeight: FontWeight.w600),textAlign: TextAlign.left,))
                              ],
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: double.infinity,
                              child:  Divider(color: Colors.grey.shade200,),
                            ),
                            SizedBox(height: 15,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(" New to Ecco? ", style: TextStyle(fontSize: 20, color: Colors.orangeAccent, fontWeight: FontWeight.w900),)),
                            Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(11.0),
                                        side: BorderSide(color: Colors.grey.shade200)
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>create_account()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(person_add_alt_1_sharp, color: Colors.blueAccent,),
                                      Text(" Create Account", style: TextStyle(color: Colors.black, fontSize: 17),),
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: double.infinity,
                              child:  Divider(color: Colors.grey.shade200,),
                            ),
                            SizedBox(height: 30,),
                            Image.asset('assets/images/progroup_logo.png'),
                            SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}