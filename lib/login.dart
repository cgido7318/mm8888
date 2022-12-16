import 'package:mm8888/firebase_options.dart';
import 'package:mm8888/first.dart';
import 'package:mm8888/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mm8888/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Login());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailContoller = TextEditingController();
  final _passwordContoller = TextEditingController();

  Future CuberisIDlogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailContoller.text.trim(),
        password: _passwordContoller.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');}
    }
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('login', true);
      }
    });
  }

  Future Guestlogin() async {
    try {
      final userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('login', true);
      }
    });
  }

  @override
  void dispose(){
    _emailContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: 100,
              child: Text(
                "Cuberis ID",
                style: TextStyle(
                  fontSize: 56,
                  color: Colors.black,
                  fontFamily: "Tmoney",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 100,
              child: Text(
                "Log in with your Cuberis ID to use your y0813",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontFamily: "Tmoney",
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(
                    Icons.email_outlined,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                controller: _emailContoller,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(
                    Icons.password_outlined,
                  ),
                  hintText: "Password",
                  border: InputBorder.none,
                ),
                controller: _passwordContoller,
                obscureText: true,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                ),
                onPressed: CuberisIDlogin,
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Tmoney",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  enableDrag: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      height: 225,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.question_mark_outlined,
                                  color: Colors.black54,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Cuberis ID ploblem",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Tmoney",
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: (){
                            },
                            leading: Icon(
                              Icons.password_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Forgot password",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const First()),
                              );
                            },
                            leading: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Don't have a Cuberis ID",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: (){
                              Guestlogin();
                            },
                            leading: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Skip (temporary anonymous accounts)",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Don't have a Cuberis ID or forgot your password?",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                  fontFamily: "Tmoney",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}