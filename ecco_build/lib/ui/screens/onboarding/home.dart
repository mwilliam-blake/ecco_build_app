import 'dart:convert';
import 'package:ecco_build/ui/screens/onboarding/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dashboard.dart';
import 'forget_password.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  bool _obscured = true;

  void login(String email , password) async {
    print("entered");

    if(email=='') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
          Text("Please enter your Email/Username"), behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
    }
    else if(password=='') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
          Text("Please enter your password"),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
    }
    else {
      Center(
        child: CircularProgressIndicator(),
      );
      try {
        Response response = await post(
            Uri.parse('http://ecco.mob-api.pro-sps.com/api/login'),
            body: {
              'email': email,
              'password': password
            }
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
              Text("User Logged-in successfully!!"),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => FABcircularAnimation()));

          ///print(data['token']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
              Text("Invalid Username or Password"),behavior: SnackBarBehavior.floating,margin: EdgeInsets.all(50),elevation: 30,));
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

     return GestureDetector(
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
                           Text("Login", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,),),
                           Text.rich(TextSpan(text: "Don't have an account?  ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                               children: [TextSpan(text: "Sign Up",  mouseCursor: WidgetStateMouseCursor.clickable, recognizer: TapGestureRecognizer()..onTap=() {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>create_account()));
                               }, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500))])
                           ),
                           SizedBox(height: 20,),
                           Align(alignment:Alignment.centerLeft, child: Text("Email", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                           TextField(
                             controller: unameController,
                             decoration: InputDecoration(
                               hintText: "Enter your Username",
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
                           Align(alignment:Alignment.centerLeft, child: Text("Password", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                           TextField(
                             obscureText: _obscured,
                             controller: pwordController,
                             obscuringCharacter: '*',
                             textInputAction: TextInputAction.done,
                             keyboardType: TextInputType.visiblePassword,
                             autofocus: false,
                             decoration: InputDecoration(
                               hintText: "Enter your Password",
                               hintStyle: TextStyle(color: Colors.grey),
                               suffixIcon: GestureDetector(
                                 onTap: () {
                                   setState(() {
                                     _obscured = !_obscured;
                                   });
                                 },
                                 child:Icon(_obscured
                                     ? Icons.visibility_off_rounded
                                     : Icons.visibility_rounded,color: Colors.grey,)
                               ),
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
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("     ",style: TextStyle(fontSize: 15, color: Colors.grey,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                               InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>forget_password()));}, child: Text("Forgot Password?", style: TextStyle(fontSize: 15, color: Colors.blueAccent,fontWeight: FontWeight.w600),textAlign: TextAlign.left,))
                             ],
                           ),
                           SizedBox(height: 15,),
                           Container(
                             width: double.infinity,
                             child: GestureDetector(
                               onTap: () {
                                 login(unameController.text.toString(), pwordController.text.toString());
                               },
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: Colors.blueAccent,
                                     borderRadius: BorderRadius.circular(10)
                                 ),
                                 child: Center(child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),),),
                               ),
                           ),),
                           SizedBox(height: 15,),
                           Container(
                             width: double.infinity,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Expanded(child: Divider(color: Colors.grey.shade200,)),
                                 SizedBox(width: 15,),
                                 Text("Or"),
                                 SizedBox(width: 15,),
                                 Expanded(child: Divider(color: Colors.grey.shade200,)),
                               ],
                             ),
                           ),
                           SizedBox(height: 15,),
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
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>FABcircularAnimation()));
                               },
                               child:
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Icons.info_sharp, color: Colors.blueAccent,),
                                   Text(" Get to Know Ecco", style: TextStyle(color: Colors.black, fontSize: 17),),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(height: 10,),
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