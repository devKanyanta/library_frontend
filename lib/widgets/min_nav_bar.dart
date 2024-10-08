import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';


class minNavBar extends StatefulWidget {
  const minNavBar({super.key});

  @override
  State<minNavBar> createState() => _minNavBarState();
}

class _minNavBarState extends State<minNavBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: minNavMobile(),
        desktop: minNavDesktop(),
    );
  }

  Widget minNavDesktop(){
    return Container(
      color: Colors.blueAccent,
      height: double.maxFinite,
      width: 65,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: ListTile(
                    leading: Icon(Icons.arrow_forward_ios, color: Colors.white), // Add this line
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to home page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to about page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.storage, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to services page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.volunteer_activism_rounded, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to contact page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to contact page
                  },
                ),
                ListTile(
                  leading: Icon(Icons.event, color: Colors.white), // Add this line
                  onTap: () {
                    // Handle navigation to contact page
                  },
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white), // Add this line
                    onTap: () {
                      // Handle navigation to contact page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white), // Add this line
                    onTap: () {
                      // Handle navigation to contact page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help, color: Colors.white), // Add this line
                    onTap: () {
                      // Handle navigation to contact page
                    },
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
  Widget minNavMobile(){
    return Container();
  }
}
