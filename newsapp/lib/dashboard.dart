import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as apiClient;
import 'package:newsapp/bloc/news_bloc.dart';
import 'package:newsapp/models/news_model.dart';

class dashboard extends StatefulWidget{
  const dashboard({super.key});
  @override
  State<StatefulWidget> createState()  => _dashboard_page();

}

class _dashboard_page extends State<dashboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(getNewsEvent());
  }

  List tabs = ["All","Politic","Nature","Education","Sports","Weather"];

  List<Map<String, dynamic>> mNavigation = [
    {
      "icon": Icons.home,
      "label": "Home",
      "navigateTo" : dashboard()
    },
    {
      "icon": Icons.explore_rounded,
      "label": "Explore",
      "navigateTo" : dashboard()
    },
    {
      "icon": Icons.bookmark,
      "label": "Saved",
      "navigateTo" : dashboard()
    },
    {
      "icon": Icons.settings,
      "label": "Setting",
      "navigateTo" : dashboard()
    }
  ];

  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold( 
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text("Morning", style: TextStyle(color: Colors.grey, fontSize: 16)),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/avathar.png",
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" Welcome", style: TextStyle(
                              color: Colors.grey, fontSize: 16)),
                          Text(
                            " Shajakhan !",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.notifications_none),
                ],
              ),
            SizedBox(height: 20,),
            TextField(controller: searchController,
              decoration: InputDecoration(
                hintText: "Lets see whct happened today",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search),
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Breaking News !", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                InkWell(
                  child: Text("See all", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                )
              ],
            ),
            SizedBox(height: 20,),
            BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if(state is getLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(state is NewsErrorState) {
                return Center(
                  child: Text("${state.errorMsg}"),
                );
              }
              else if(state is getLoadedState) {
                var mdataModel = state.dData;
                double c_width = MediaQuery.of(context).size.width*0.7;
                return   SizedBox(
                    width: double.infinity,
                    height: 240,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      itemCount: mdataModel.artical?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,),
                      itemBuilder: (BuildContext cntx, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border(top: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black),right: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black), left: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black), bottom: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black)),
                            image: DecorationImage(image: NetworkImage("${mdataModel.artical?[index].urlToImage}"),fit: BoxFit.cover,opacity: 0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border(top: BorderSide(color: Colors.grey,width: 1), right: BorderSide(color: Colors.grey,width: 1),bottom: BorderSide(color: Colors.grey,width: 1),left: BorderSide(color: Colors.grey,width: 1),)
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.local_fire_department_outlined, color: Colors.red,),
                                          Center(child: Text("Hot", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border(top: BorderSide(color: Colors.grey,width: 1), right: BorderSide(color: Colors.grey,width: 1),bottom: BorderSide(color: Colors.grey,width: 1),left: BorderSide(color: Colors.grey,width: 1),)
                                          ),
                                          child:
                                              Center(child: Text("Nature", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border(top: BorderSide(color: Colors.grey,width: 1), right: BorderSide(color: Colors.grey,width: 1),bottom: BorderSide(color: Colors.grey,width: 1),left: BorderSide(color: Colors.grey,width: 1),)
                                          ),
                                          child:
                                              Center(child: Text("Animal", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("dsfsdfdfs"),
                                        Text("dsfsdfdfs"),
                                        Text("dsfsdfdfs"),
                                        Text("dsfsdfdfs")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            decoration: new BoxDecoration(
                                              gradient: new LinearGradient(
                                                end: const Alignment(0.0, -1),
                                                begin: const Alignment(0.0, 0.6),
                                                colors: <Color>[
                                                  const Color(0x8A000000),
                                                  Colors.black12.withOpacity(0.0)
                                                ],
                                              ),
                                            ),
                                            width: c_width,
                                            child: Text("${mdataModel.artical?[index].title}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),)),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  );
                  //Text("${mdataModel.artical?.length}");
              }
              return Container();
            }
        ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending Right Now", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                InkWell(
                  child: Text("See all", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600),),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 75,
              child: ListView.builder(
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext contxt, int idex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: tabs[idex]=='All'?Colors.blueAccent:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border(top: BorderSide(color: tabs[idex]=='All'?Colors.blueAccent:Colors.grey,width: 1), right: BorderSide(color: tabs[idex]=='All'?Colors.blueAccent:Colors.grey,width: 1),bottom: BorderSide(color: tabs[idex]=='All'?Colors.blueAccent:Colors.grey,width: 1),left: BorderSide(color: tabs[idex]=='All'?Colors.blueAccent:Colors.grey,width: 1),)
                      ),
                      child: Center(child: Text("${tabs[idex]}", style: TextStyle(color: tabs[idex]=='All'?Colors.white:Colors.grey, fontWeight: FontWeight.w600),)),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index){
          },
          destinations: mNavigation.map((e){
            return NavigationDestination(icon: Icon(e['icon']), label: e['label']);
          }).toList()
      )
    );
  }

}