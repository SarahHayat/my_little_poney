import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_little_poney/widets/test.dart';
import 'package:my_little_poney/widgets/contest.dart';
import 'package:my_little_poney/widgets/list_event.dart';
import 'package:my_little_poney/widgets/profile_page.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  Widget getBody() {
    if (_selectedIndex == 0) {
      // return the first page
      return const ContestListView(title: 'Concours');
    } else if (_selectedIndex == 1) {
      // return the second page
      return ProfilePage();
    } else {
      // return the third page
      return const ListEvents();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            ListTile(
              // Maybe put profil here
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  // put the profile index
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
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
