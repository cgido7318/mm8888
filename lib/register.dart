import 'package:mm8888/firebase_options.dart';
import 'package:mm8888/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Register());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailContoller = TextEditingController();
  final _passwordContoller = TextEditingController();
  bool _isChecked = false;

  Future login() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailContoller.text.trim(),
      password: _passwordContoller.text.trim(),
    );
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
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: 100,
              child: Text(
                "Welcome",
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
                "Automatic identity verification which enables you p to verify your identity",
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
            /* SizedBox(
              width: double.infinity,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                    ),
                    onPressed: null,
                    child: const Text(
                      "Agree to our Terms,\nData Policy and Cookies Policy",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontFamily: "Tmoney",
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value){
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  )
                ],
              ),
            ),
             */
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                ),
                onPressed: login,
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Tmoney",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                  ),
                  onPressed: null,
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontFamily: "Tmoney",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontFamily: "Tmoney",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}