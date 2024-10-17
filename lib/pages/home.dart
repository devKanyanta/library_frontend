import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_web/utils/colors.dart';
import 'package:library_web/widgets/books.dart';
import 'package:library_web/widgets/fine_list.dart';
import 'package:library_web/widgets/get_loan.dart';
import 'package:library_web/widgets/loans.dart';
import 'package:library_web/widgets/loans_student.dart';
import 'package:library_web/widgets/reservations.dart';
import 'package:library_web/widgets/reservations_lib.dart';
import 'package:library_web/widgets/students.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String selectedPage = 'Choose';
  String role = "null";
  String userId = '';

  void determineRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.get('user_id').toString();
    if (prefs.get('role') == 'librarian') {
      print("Librarian");
      setState(() {
        role = "Librarian";
      });
    } else if (prefs.get('role') == "student") {
      print("Student");
      setState(() {
        role = "Student";
      });
    } else {
      print("Nothing exists");
    }
  }

  @override
  void initState() {
    super.initState();
    determineRole();
  }

  @override
  Widget build(BuildContext context) {
    if(role=="Librarian"){
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
                            leading: Icon(Icons.storage, color: Colors.white),
                            title: const Text(
                              'Reservations',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                selectedPage = 'Reserv';
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
    }else if (role == "Student"){
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
                              'Get Loan',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                selectedPage = 'getLoan';
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.people, color: Colors.white),
                            title: const Text(
                              'Make reservation',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                selectedPage = 'reservation';
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.storage, color: Colors.white),
                            title: const Text(
                              'View Loans',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                selectedPage = 'viewLoans';
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.volunteer_activism_rounded, color: Colors.white),
                            title: const Text(
                              'View Fines',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                selectedPage = 'viewFines';
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
    } else if(role == "null"){
      return const Center(
          child: CircularProgressIndicator()
      );
    }else{
      return Container();
    }
  }

  // Function to return the appropriate widget based on selected page
  Widget getPageWidget(String selectedPage) {
    switch (selectedPage) {
      case 'Books':
        return Books();
      case 'Students':
        return Students();
      case 'Loans':
        return Loans();
      case 'Fines':
        return FineListScreen(role: role);
      case 'getLoan':
        return GetLoan();
      case 'reservation':
        return Reservations(userId: userId,);
      case 'Reserv':
        return ReservationListScreen();
      case 'viewFines':
        return FineListScreen(role: role,);
      case 'viewLoans':
        return StudentLoans();
      case 'Choose':
        return chooseOption();
      case 'Logout':
        return logout();
      default:
        return Text('Unknown Page', style: TextStyle(fontSize: 24));
    }
  }
}

class chooseOption extends StatelessWidget {
  const chooseOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Choose from the options to your left',
        style: TextStyle(
          color: AppColors.blueBackground,
          fontSize: 24
        ),
      ),
    );
  }
}


class logout extends StatefulWidget {
  const logout({super.key});

  @override
  State<logout> createState() => _logoutState();
}

class _logoutState extends State<logout> {
  void logout()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    context.go('/');
  }
  @override
  void initState() {
    // TODO: implement initState
    logout();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


