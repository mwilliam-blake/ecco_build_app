import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecco_build/data/remote/models/login_reg_model.dart';
import 'package:ecco_build/ui/screens/bloc/register/register_bloc.dart';
import 'package:ecco_build/ui/screens/bloc/register/register_event.dart';
import 'package:ecco_build/ui/screens/bloc/register/register_state.dart';
import 'package:ecco_build/ui/screens/onboarding/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as apiClient;
import 'dashboard.dart';

class create_account extends StatefulWidget {
  @override
  State<create_account> createState() => _create_accountState();
}

class _create_accountState extends State<create_account> {
  List Tradelist = [];
  List Positionlist = [];
  List Clientlist = [];
  bool? _checkTermss = false;
  bool isLoading = false;
  String selectedpTrade = '';
  String selectedsTrade = '';
  String selectedtTrade = '';
  String selectedPosition = '';
  String selectedClient = '';
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController unameController = TextEditingController();
  TextEditingController pNoController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<RegisterModel?> getRegApi() async{
    /// api client call
    String url = "http://ecco.mob-api.pro-sps.com/api/get_values";

    apiClient.Response res = await apiClient.post(Uri.parse(url));

    if(res.statusCode==200){
      ///all okay
      RegisterModel mData = RegisterModel.fromJson(jsonDecode(res.body));
      setState(() {
        Tradelist = mData.Trades as List;
        Positionlist = mData.Position as List;
        Clientlist = mData.Client as List;
      });
    } else {
      print("Error: ${res.statusCode}");
      return null;
    }
  }

  /* Future<RegisterModel> getRegApi ()async{
    try {
      final response = await post(Uri.parse('http://ecco.mob-api.pro-sps.com/api/get_values')) ;
      final body = json.decode(response.body) as List;
      if(response.statusCode == 200) {
        print(response.body);
        /* return  body.map((dynamic json) {
            final map = json as Map<String, dynamic>;
            return  RegisterModel(
              Trades: map['Trades'],
              Position: map['Position'],
              Client: map['Client'],
            );
          }).toList(); */
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }
    throw Exception('error fetching data');

  } */

  @override
  void initState() {
    super.initState();
    getRegApi();
  }

  @override
  Widget build(BuildContext context) {




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
                padding: const EdgeInsets.symmetric(horizontal:10, vertical: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20, vertical: 10),
                    child: Column(
                      children: [
                        Text("Create Account", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,),),
                        Text.rich(TextSpan(text: "Already have an account?  ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                            children: [TextSpan(text: "Sign In", recognizer: TapGestureRecognizer()..onTap=() {
                            Navigator.pop(context);
                            }, style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500))])
                        ),
                        SizedBox(height: 20,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 1: Fill your Information", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        TextField(
                          controller: fnameController,
                          decoration: const InputDecoration(
                            hintText: "First Name",
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
                        SizedBox(height: 10,),
                        TextField(
                          controller: lnameController,
                          decoration: const InputDecoration(
                            hintText: "Last Name",
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
                        SizedBox(height: 10,),
                        TextField(
                          controller: unameController,
                          decoration: const InputDecoration(
                            hintText: "Username",
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
                        SizedBox(height: 10,),
                        TextField(
                          controller: pNoController,
                          decoration: const InputDecoration(
                            hintText: "(+123) 456-7890",
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
                        SizedBox(height: 10,),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
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
                        Align(alignment:Alignment.centerLeft, child: Text("Step 2: Primary Trade", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        DropdownMenu(
                            width: double.infinity,
                            hintText: "Primary Trade",
                            inputDecorationTheme: InputDecorationTheme(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                        color: Color(0xffdfd3d3)
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            initialSelection: selectedpTrade,
                            onSelected: (value){
                              selectedpTrade = value!;
                            },
                            dropdownMenuEntries: Tradelist.map((value) {
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList()),
                        SizedBox(height: 15,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 3: Secondary Trade", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        DropdownMenu(
                            width: double.infinity,
                            hintText: "Secondary Trade",
                            inputDecorationTheme: InputDecorationTheme(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            initialSelection: selectedsTrade,
                            onSelected: (value){
                              selectedsTrade = value!;
                            },
                            dropdownMenuEntries: Tradelist.map((value){
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList()),
                        SizedBox(height: 15,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 4: Third Trade", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        DropdownMenu(
                            width: double.infinity,
                            hintText: "Third Trade",
                            inputDecorationTheme: InputDecorationTheme(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            initialSelection: selectedtTrade,
                            onSelected: (value){
                              selectedtTrade = value!;
                            },
                            dropdownMenuEntries: Tradelist.map((value){
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList()),
                        SizedBox(height: 15,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 5: Position", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        DropdownMenu(
                            width: double.infinity,
                            hintText: "Position",
                            inputDecorationTheme: InputDecorationTheme(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            initialSelection: selectedPosition,
                            onSelected: (value){
                              selectedPosition = value!;
                            },
                            dropdownMenuEntries: Positionlist.map((value){
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList()),
                        SizedBox(height: 15,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 6: Client", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        DropdownMenu(
                            width: double.infinity,
                            hintText: "Client",
                            inputDecorationTheme: InputDecorationTheme(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Color(0xffdfd3d3),
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            initialSelection: selectedClient,
                            onSelected: (value){
                              selectedClient = value!;
                            },
                            dropdownMenuEntries: Clientlist.map((value){
                              return DropdownMenuEntry(value: value, label: value);
                            }).toList()),
                        SizedBox(height: 15,),
                        Align(alignment:Alignment.centerLeft, child: Text("Step 7: Notes to Administrator", style: TextStyle(fontSize: 17, color: Colors.black,),textAlign: TextAlign.left,)),
                        TextField(
                          controller: notesController,
                          minLines: 4,
                          maxLines: 10,
                          decoration: const InputDecoration(
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
                        SizedBox(height: 10,),
                        CheckboxListTile(
                          title: Text("I agree to the Terms and Privacy."),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          value: _checkTermss,
                          onChanged: (newValue) {
                            setState(() {
                              _checkTermss = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),
                        SizedBox(height: 10,),
                        Text.rich(TextSpan(text: "Already have an account?  ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                            children: [TextSpan(text: "Sign In",recognizer: TapGestureRecognizer()..onTap=() {
                              Navigator.pop(context);
                            }, style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500))])
                        ),
                        SizedBox(height: 5,),
                        BlocListener<RegisterBloc, RegisterState>(listener: (context,state) {
                          print(state);
                          if(state is RegisterLoadingState) {
                            isLoading=true;
                            setState(() {});
                          }

                          if(state is RegisterErrorState) {
                            isLoading = false;
                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMsg}")));
                          }

                          if(state is RegisterLoadedState) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registered Successfully. \n Thank you for creating an account on Ecco.  The administrator will approve your account and send a temporary password to your email.")));
                            Navigator.pop(context);
                          }

                        }, child: Container(
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
                              if(fnameController.text=='')  {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your first name.")));
                              }
                              else if(lnameController.text=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your last name.")));
                              }
                              else if(unameController.text=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your username.")));
                              }
                              else if(pNoController.text=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your phone number.")));
                              }
                              else if(emailController.text=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Email address.")));
                              }
                              else if(selectedpTrade=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select your Primary Trade.")));
                              }
                              else if(selectedsTrade=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select your Secondary Trade.")));
                              }
                              else if(selectedtTrade=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select your third Trade.")));
                              }
                              else if(selectedPosition=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select your position.")));
                              }
                              else if(selectedClient=='') {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select your Client.")));
                              }
                              else if(_checkTermss==false) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please accept our Terms and Privacy.")));
                              }
                              else {
                                 context.read<RegisterBloc>().add(
                                    RegisterUserEvent(
                                        fname: fnameController.text,
                                        lname: lnameController.text,
                                        uname: unameController.text,
                                        mobNo: pNoController.text,
                                        email: emailController.text,
                                        pTrade: selectedpTrade,
                                        sTrade: selectedsTrade,
                                        tTrade: selectedtTrade,
                                        position: selectedPosition,
                                        client: selectedClient,
                                        notes: notesController.text));
                              }
                            },
                            child: isLoading?Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 11,),
                                Text("Registering..."),
                              ],
                            ):Text("Create a new account", style: TextStyle(color: Colors.white, fontSize: 20),),),
                        ),),
                        SizedBox(height: 15,),
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