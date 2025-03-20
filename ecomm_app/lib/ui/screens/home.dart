import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePages extends StatelessWidget {
  List mdata = [
    {"image": "lib/domain/app/assets/images/shoes.jpg", "cat":"Shoes"},
    {"image": "lib/domain/app/assets/images/beauty.jpg", "cat":"Beauty"},
    {"image": "lib/domain/app/assets/images/women.jpg", "cat":"women's Fashion"},
    {"image": "lib/domain/app/assets/images/jewel.jpg", "cat":"Jewelry"},
    {"image": "lib/domain/app/assets/images/mens.jpg", "cat":"Men's Fasion"},
    {"image": "lib/domain/app/assets/images/electronics.jpg", "cat":"Electronics"},
    {"image": "lib/domain/app/assets/images/mob.png", "cat":"Mobiles"},
    {"image": "lib/domain/app/assets/images/sports.jpg", "cat":"Sports"},
  ];

  List pdata = [
    {"image": "lib/domain/app/assets/images/headphone.png", "cat":"Wireless Headphone","price":"120"},
    {"image": "lib/domain/app/assets/images/beauty.jpg", "cat":"Women Sweater","price":"220"},
    {"image": "lib/domain/app/assets/images/women.jpg", "cat":"Smart Watch","price":"250"},
    {"image": "lib/domain/app/assets/images/jewel.jpg", "cat":"Speaker","price":"95"},
    {"image": "lib/domain/app/assets/images/mens.jpg", "cat":"Smart Phone","price":"310"},
    {"image": "lib/domain/app/assets/images/electronics.jpg", "cat":"Hair Dryer","price":"110"},
    {"image": "lib/domain/app/assets/images/mob.png", "cat":"Power Bank","price":"50"},
    {"image": "lib/domain/app/assets/images/sports.jpg", "cat":"Laptop","price":"450"},
  ];

  @override
  Widget build(BuildContext context) {
     final orientation = MediaQuery.of(context).orientation;
     return Scaffold(
       body: SafeArea(child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.grid_view_rounded, size: 20, color: Colors.black,),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.notifications_none, size: 20, color: Colors.black,),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // icons at the end of the input
                    mainAxisSize: MainAxisSize.min, // occupying the minimum input space
                    children: [
                      Text("|", style: TextStyle(fontSize: 25),),
                      SizedBox(width: 10,),
                      Icon(IconData(0xe413, fontFamily: 'MaterialIcons')),
                      SizedBox(width: 15,),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset("lib/domain/app/assets/images/banner.png")),
              SizedBox(height: 20,),
              Container(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: mdata.length,
                  itemBuilder: (context, count) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 65,
                        height: double.infinity,
                        child: Column(
                          children: [
                            CircleAvatar(
                                  backgroundImage: AssetImage(mdata[count]['image']),
                                  radius: 30.0,
                            ),
                            Text(mdata[count]['cat'])
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Special For You", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
                  Text("See all", style: TextStyle(color: Colors.grey),)
                ],
              ),
              SizedBox(height: 20,),
              Expanded(child:
                GridView.builder(
                  itemCount: pdata.length,//data.length
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Image.asset(pdata[index]['image'],width: 160, fit: BoxFit.contain, height: 80,),
                            SizedBox(height: 10,),
                            Text(pdata[index]['cat'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14,),),
                            Text("\$${pdata[index]['price']}.00", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15,),)
                          ],
                        ),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        )
       ),
     );
  }
  
}