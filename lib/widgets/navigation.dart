import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:my_little_poney/models/User.dart';
import 'package:my_little_poney/widgets/contest_view.dart';
import 'package:my_little_poney/widgets/party.dart';
import 'package:my_little_poney/widgets/lesson.dart';
import 'package:my_little_poney/widgets/lesson_view.dart';
import 'package:my_little_poney/widgets/horses_list.dart';
import 'package:my_little_poney/widgets/list_event.dart';
import 'package:my_little_poney/widgets/manage_event.dart';
import 'package:my_little_poney/widgets/planning_lesson.dart';
import 'package:my_little_poney/widgets/profile_page.dart';
import 'package:my_little_poney/widgets/users_list.dart';

import 'contest.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  int _drawerSelectedIndex = 0;
  bool _isLastTappedDrawer = true;
  late User user;
  LocalStorage storage = LocalStorage('poney_app');

  @override
  void initState() {
    super.initState();
    user = User.fromJson(storage.getItem('user'));
  }

  List<Map<String, dynamic>> drawerLinks = [
    {"widget": ListEvents(), "title": "Liste des événements"},
    {"widget": ProfilePage(), "title": "Profile"},
    {"widget": UsersList(), "title": "Liste des utilisateurs"},
    {"widget": HorsesList(), "title": "Liste des cheveaux"},
    {"widget": ManageEvent(), "title": "Gestion écurie"},
    {"widget": PlanningLesson(), "title": "Planning des cours"},
    {
      "widget": ContestListView(title: 'Concours'),
      "title": "Liste des concours"
    },
    {"widget": LessonListView(title: 'Cours'), "title": "Liste des cours"},
    {"widget": PartyListView(title: 'Soirées'), "title": "Liste des soirés"}
  ];
  List<Map<String, dynamic>> bottomBarLinks = [
    {
      "widget": ContestListView(title: 'Liste des événements'),
      "title": "Evenement",
      "icon": Icon(Icons.list)
    },
    {
      "widget": LessonListView(title: 'Cours'),
      "title": "Cours",
      "icon": Icon(Icons.play_lesson)
    },
    {
      "widget": PartyListView(title: 'Soirées'),
      "title": "Soirées",
      "icon": Icon(Icons.party_mode)
    },
  ];

  Widget getBody() {
    if(_isLastTappedDrawer){
      return drawerLinks[_drawerSelectedIndex]["widget"];
    }
    else{
      return bottomBarLinks[_selectedIndex]["widget"];
    }
  }

  List<Widget> getDrawerLinks(BuildContext context){
    List<Widget> links = [];
    for(int i=0; i<drawerLinks.length; i++) {
      links.add(_buildDrawerLinks(drawerLinks[i]["title"], ()=> _onDrawerTap(i, context)));
    }
    return links;
  }
  List<BottomNavigationBarItem> getBottomBarLinks(){
    List<BottomNavigationBarItem> links = [];
    for(int i=0; i<bottomBarLinks.length; i++) {
      links.add(_buildBottomBarButton(i));
    }
    return links;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isLastTappedDrawer = false;
    });
  }

  void _onDrawerTap(int index, BuildContext context){
    setState(() {
      _drawerSelectedIndex = index;
      _isLastTappedDrawer = true;
    });
    Navigator.pop(context);
  }

  _buildDrawerLinks(String title, Function onTap){
    return ListTile(
      title: Text(title),
      onTap: ()=>onTap(),
    );
  }
  BottomNavigationBarItem _buildBottomBarButton(int index){
    return BottomNavigationBarItem(
      icon: bottomBarLinks[index]["icon"],
      label: bottomBarLinks[index]["title"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        user.profilePicture!)),
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  user.userName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    fontSize: 30.0
                  ),
                ),
              ),
            ),
            ...getDrawerLinks(context)
          ] ,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomBarLinks(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
