import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class FABcircularAnimation extends StatefulWidget {
  const FABcircularAnimation({super.key});

  @override
  State<FABcircularAnimation> createState() => _FABcircularAnimationState();
}

class _FABcircularAnimationState extends State<FABcircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  /* List<Map<String,dynamic>> mNavigate = [
    {
      "icon":Icons.home,
      "label":"Home",
      "navigateTo":""
    },
    {
      "icon":Icons.luggage,
      "label":"Briefcase",
      "navigateTo":""
    },
    {
      "icon":Icons.factory,
      "label":"Projects",
      "navigateTo":""
    }
    ,
    {
      "icon":Icons.add_alert_sharp,
      "label":"Announcement",
      "navigateTo":""
    }
  ]; */
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.settings, color: Colors.white,),
              Text(
                "Home",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Icon(Icons.logout, color: Colors.white,)
            ],
          ),
        backgroundColor: Colors.transparent,
      ),
      body:
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/Home_bg.png"),fit: BoxFit.cover),
          ),
          child:   SafeArea(child: Text("", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),))),

      bottomNavigationBar:
      BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home, color: Colors.pinkAccent,size: 30,),
                  padding: EdgeInsets.zero,
                  tooltip: "Home",
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.next_week, color: Colors.orange,size: 30,),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  tooltip: "Briefcase",
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.task, color: Colors.black,size: 30,),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  tooltip: "Projects",
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.campaign, color: Colors.deepOrange,size: 30,),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  tooltip: "Announcements",
                ),
              ],
            ),

          ],
        ),
        //mNavigate.map((e){
        //return NavigationDestination(icon: Icon(e['icon']), label: e['label']);
      //}).toList(),
    ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: RadialAnimatedMenu(
          controller: controller,
        ),
        onPressed: () {
          print('sdfadsf125');
        },
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }
}
// that's it from today video thank you
class RadialAnimatedMenu extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translate;
  final Animation<double> rotation;
  RadialAnimatedMenu({super.key, required this.controller})
      : scale = Tween<double>(begin: 1, end: 0.0).animate(
    CurvedAnimation(parent: controller, curve: Curves.linear),
  ),
        translate = Tween<double>(begin: 0.0, end: 110.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.ease),
        ),
        rotation = Tween<double>(begin: 0.0, end: 360.8).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0.0, 0.8, curve: Curves.bounceIn)),
        );



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, index) {
        return Transform.rotate(
          angle: radians(rotation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //itemsButton(0, color: Colors.orange, icon: Icons.home),
              //itemsButton(45, color: Colors.purple, icon: luggage),
             // itemsButton(90, color: Colors.indigo, icon: Icons.baby_changing_station),
              //itemsButton(135, color: Colors.pink, icon: Icons.cabin),
              //itemsButton(180, color: Colors.blue, icon: Icons.dangerous),
              itemsButton(225, color: Colors.grey, icon: Icons.task_sharp),
              itemsButton(270, color: Colors.deepOrangeAccent, icon: Icons.construction),
              itemsButton(315, color: Colors.orange, icon: Icons.person),
              Transform.scale(
                scale: scale.value - 1.3,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: close,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.cancel_presentation_rounded),
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child:
                FloatingActionButton(
                  heroTag: null,
                  onPressed: open,
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.chat, color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  itemsButton(double angle, {required Color color, required IconData icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translate.value) * cos(rad),
          (translate.value) * sin(rad),
        ),
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: color,
        onPressed:() {
          print("sdfsdf${angle}");
        },
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  open() {
    controller.forward();
  }

  close() {
    controller.reverse();
  }

}
void _triggerBottomSheet(context){
  showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
          ListTile(
            leading: Icon(Icons.copy),
            title: Text('Copy Link'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ],
      );
    },
  );
}