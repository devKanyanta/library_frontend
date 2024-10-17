import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_web/pages/home.dart';
import 'package:library_web/services/auth_services.dart';
import 'package:library_web/utils/colors.dart';
import 'package:library_web/widgets/email_input_field.dart';
import 'package:library_web/widgets/id_input.dart';
import 'package:library_web/widgets/last_name.dart';
import 'package:library_web/widgets/name_input_field.dart';
import 'package:library_web/widgets/password_input_field.dart';
import 'package:library_web/widgets/phone_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => route(),
        ),
        GoRoute(
          path: '/sign-up',
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => Login(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class route extends StatefulWidget {
  const route({super.key});

  @override
  State<route> createState() => _routeState();
}

class _routeState extends State<route> {

  void checkAuth() async {
    // Save email and user type to browser cache
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('user_id') != null) {
      context.go('/home');
    }else{
      context.go('/login');
    }
  }

  @override
  void initState() {
    checkAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;
  String? response;
  bool isLogin = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
              width: 650,
              height: 454,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(2, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 219,
                      height: 454,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1521790945508-bf2a36314e85?q=80&w=1934&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Library Management System",
                              style: TextStyle(
                                  color: AppColors.blueText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Create an Account",
                              style: TextStyle(
                                  color: AppColors.blueGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            EmailInput(
                              hintText: 'Email',
                              onChanged: (value){
                                email = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            PasswordInput(
                              hintText: 'Password',
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                            const SizedBox(height: 16),
                            isLogin ? const CircularProgressIndicator() : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                backgroundColor: AppColors.blueButton,
                                splashFactory: InkRipple.splashFactory,
                              ),
                              onPressed: () async {
                                setState(() {
                                  isLogin = true;
                                });

                                try {
                                  print("email: $email and pass: $password");
                                  // Call loginUser and wait for the result
                                  String loginResponse = await _authService.loginUser(email!, password!);
                                  response = loginResponse;

                                  // Show success message in a SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loginResponse)),
                                  );

                                  context.go('/home');
                                } catch (e) {
                                  // Show error message in a SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $e")),
                                  );
                                } finally {
                                  setState(() {
                                    isLogin = false;
                                  });
                                }
                              },
                              child: const Text(
                                  'Login',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                context.go('/sign-up');
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Text(
                                "Don'\t have an account? Log In.",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String role = 'student';
  String password = "";
  String response = "";
  final AuthService _authService = AuthService();
  bool firstPage = true;
  bool secondPage = false;
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 650,
            height: 454,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(2, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 219,
                  height: 454,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1521790945508-bf2a36314e85?q=80&w=1934&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                firstPage ? Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Library Management System",
                          style: TextStyle(
                              color: AppColors.blueText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Create an Account",
                          style: TextStyle(
                              color: AppColors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Select User Type',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: role,
                          decoration: const InputDecoration(
                            labelText: 'Role',
                            border: OutlineInputBorder(),
                          ),
                          items: <String>['student', 'librarian']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              role = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 25),
                        Text(
                          "First name",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        NameInput(
                          hintText: 'First name',
                          onChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Last name",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        LastNameInput(
                          hintText: 'Last name',
                          onChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        SizedBox(height: 13),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                firstPage = false;
                                secondPage = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: Text(
                            'Aready have an account? Log In.',
                            style: TextStyle(
                                fontSize: 14, color: Colors.blueAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ) : secondPage ?
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Student ID/NRC",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        IdInput(
                          hintText: 'ID',
                          onChanged: (value) {
                            setState(() {
                              id = value;
                            });
                          },
                        ),
                        Text(
                          "Email address",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        EmailInput(
                          hintText: 'Email',
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(height: 13),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    firstPage = true;
                                    secondPage = false;
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    firstPage = false;
                                    secondPage = false;
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                    :
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone Number",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        PhoneInput(
                          hintText: 'Phone Number',
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Password",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        PasswordInput(
                          hintText: 'Password',
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        SizedBox(height: 13),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              secondPage = true;
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 14, color: Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 13),
                        isLogin ? const CircularProgressIndicator() : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: AppColors.blueButton,
                            splashFactory: InkRipple.splashFactory,
                          ),
                          onPressed: () async {
                            isLogin = true;
                            // print(firstName+lastName+id+email+phoneNumber+role+password);
                            try {
                              // Call loginUser and wait for the result
                              String loginResponse = await _authService.registerUser(
                                  id,
                                  firstName,
                                  lastName,
                                  email,
                                  phoneNumber,
                                  role,
                                  password
                              );
                              response = loginResponse;

                              // Show success message in a SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(loginResponse)),
                              );

                              context.go('/home');
                            } catch (e) {
                              // Show error message in a SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            } finally{
                              setState(() {
                                isLogin = false;
                              });
                            }
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],

            ),
          )
        ),
      ),
    );
  }
}