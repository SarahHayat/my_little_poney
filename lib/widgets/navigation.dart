import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/widgets/contest.dart';
import 'package:my_little_poney/widgets/horses_list.dart';
import 'package:my_little_poney/widgets/list_event.dart';
import 'package:my_little_poney/widgets/manage_event.dart';
import 'package:my_little_poney/widgets/planning_lesson.dart';
import 'package:my_little_poney/widgets/profile_page.dart';
import 'package:my_little_poney/widgets/users_list.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  int _drawerSelectedIndex = 0;
  List<Widget> drawerLinks = [
    //const ContestListView(title: 'Concours'),
    ProfilePage(),
    const UsersList(),
    const HorsesList(),
    const ManageEvent(),
    const PlanningLesson()
  ];

  Widget getBody() {
    if(drawerLinks.length>=_drawerSelectedIndex){
      return drawerLinks[_drawerSelectedIndex];
    }
    else{
      return const ListEvents();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onDrawerTap(int index, BuildContext context){
    setState(() {
      _drawerSelectedIndex = index;
    });
    Navigator.pop(context);
  }

  _buildDrawerLinks(String title, Function onTap){
    return ListTile(
      title: Text(title),
      onTap: ()=>onTap(),
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
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2021/09/27/11/01/man-6660387__480.jpg")),
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('Pablo'),
              ),
            ),
            _buildDrawerLinks("Profile", ()=> _onDrawerTap(1, context)),
            _buildDrawerLinks("Liste des utilisateurs", ()=>_onDrawerTap(2, context)),
            _buildDrawerLinks("Liste des cheveaux", ()=>_onDrawerTap(3, context)),
            _buildDrawerLinks("Gestion écurie", ()=>_onDrawerTap(4, context)),
            _buildDrawerLinks("Planning des cours", ()=>_onDrawerTap(5, context)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            label: 'Concours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            label: 'Item 3',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
