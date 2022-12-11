import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:mm8888/login.dart';
import 'package:mm8888/main.dart';
import 'package:mm8888/setting.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const First());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  void initState() {
    print("First initState Completed");
    _tagCheck();
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _tagCheck() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    print(uid);
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$uid/tags').get();
    if (snapshot.exists) {
      print(snapshot.value);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp())
      );
    } else {
      print('No data available.');
      _tagSet();
    }
  }

  _tagSet(){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '&&',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        leading: const IconButton(
          icon:Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: null,
        ),
        actions: [
          const IconButton(
            icon:Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          IconButton(
            icon:Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setting()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        primary: Colors.white,
                      ),
                      child: Text(
                          "A"
                      ),
                      onPressed: (){

                      },
                    ),
                    SizedBox(
                      width: 75,
                    )
                  ],
                );
              },
            ),
          ),
          GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              padding: const EdgeInsets.all(4),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                  ),
                );
              }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(
            Icons.change_circle_outlined
        ),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

