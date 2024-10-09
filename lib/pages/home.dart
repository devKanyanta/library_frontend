import 'package:flutter/material.dart';
import 'package:library_web/widgets/books.dart';
import 'package:library_web/widgets/students.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Show side navigation bar for large screens
          return DesktopView();
        } else {
          // Show drawer for small screens
          return MobileView();
        }
      },
    );
  }
}

class MobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web Drawer'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle Home tap
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle Settings tap
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle About tap
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'This is the mobile view with a drawer!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class DesktopView extends StatefulWidget {
  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  // Variable to keep track of the selected page
  String selectedPage = 'Books';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            backgroundColor: Colors.blueAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 30, left: 18, bottom: 20),
                              child: Text(
                                'Library Management',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.dashboard, color: Colors.white),
                          title: const Text(
                            'Books',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPage = 'Books';
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.people, color: Colors.white),
                          title: const Text(
                            'Students',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPage = 'Students';
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.storage, color: Colors.white),
                          title: const Text(
                            'Loans',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPage = 'Loans';
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.volunteer_activism_rounded, color: Colors.white),
                          title: const Text(
                            'Fines',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPage = 'Fines';
                            });
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
                          leading: Icon(Icons.logout, color: Colors.white),
                          title: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPage = 'Logout';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: getPageWidget(selectedPage),
            ),
          ),
        ],
      ),
    );
  }

  // Function to return the appropriate widget based on selected page
  Widget getPageWidget(String selectedPage) {
    switch (selectedPage) {
      case 'Books':
        return Books();
      case 'Students':
        return Students();
      case 'Loans':
        return Text('Cluster Page Content', style: TextStyle(fontSize: 24));
      case 'Fines':
        return Text('Active Element Page Content', style: TextStyle(fontSize: 24));
      case 'Logout':
        return Text('Chat Page Content', style: TextStyle(fontSize: 24));
      default:
        return Text('Unknown Page', style: TextStyle(fontSize: 24));
    }
  }
}
