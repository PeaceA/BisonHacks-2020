import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView(
            padding: EdgeInsets.only(top: 20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width >= 500
                    ? 2
                    : MediaQuery.of(context).size.width >= 700 ? 2 : 1),
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.lightGreen[200],
                child: Center(
                  child: Text(
                    "Invest",
                    style: TextStyle(color: Colors.green[900], fontSize: 30.0),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.lightBlue[200],
                child: Center(
                  child: Text(
                    "Advising",
                    style: TextStyle(color: Colors.blue[900], fontSize: 30.0),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.orange[200],
                child: Center(
                  child: Text(
                    "Supplier",
                    style: TextStyle(
                        color: Colors.deepOrange[900], fontSize: 30.0),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(40.0),
                elevation: 3.0,
                color: Colors.purple[200],
                child: Center(
                  child: Text(
                    "Renters",
                    style: TextStyle(
                        color: Colors.deepPurple[900], fontSize: 30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

