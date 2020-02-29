import 'package:bridge_it/dashboard.dart';
import 'package:bridge_it/message.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "BridgeIt",
                style: TextStyle(letterSpacing: 1.2),
              ),
            ),
          ],
          
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.amber,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Dashboard(),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.yellow],
                  ),
                ),
                accountName: Text(
                  "Jane Doe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(
                  colors: Colors.deepPurple,
                ),
                accountEmail: Text(
                  "jane.doe@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Colors.amber,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.brown,
                ),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  "Chatting",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  message(context);
                },
                
              ),
              Divider(height: 180.0,),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.deepOrange,
                ),
                title: Text(
                  "Contact",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
