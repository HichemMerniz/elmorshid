import 'package:flutter/material.dart';
import 'package:elmorshid/Ui/Map.dart';
import 'package:elmorshid/Ui/addVoyage.dart';
import 'package:elmorshid/Ui/addPlace.dart';
import 'package:elmorshid/Ui/Profil.dart';
import 'package:elmorshid/Ui/Place.dart';
import 'package:elmorshid/Auth/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:elmorshid/Ui/Reservation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new stateHome();
  }
}

final _user = new Login();

class stateHome extends State<Home> {
  int _cIndex = 0;

  void navigationTapped(int index) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Place()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Reservation()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Map()),
        );
        break;
    }
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _gSignin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var user = new stateHome();

    return new Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: new AppBar(
        title: new Text('Elmorshid'),
        backgroundColor: Colors.deepPurple,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _cIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.place),
            title: new Text('place'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.hotel),
            title: new Text('reservation'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('map'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.deepPurple,
        onTap: navigationTapped,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("hichem"),
              accountEmail: Text("Hichembba97@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.deepPurple
                        : Colors.white,
                child: Text(
                  "H",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("Add voyage"),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addVoyage()),
                  ),
              trailing: Icon(
                Icons.add_circle,
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              title: Text('Profil'),
              trailing: Icon(
                Icons.person,
                color: Colors.deepPurple,
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  ),
            ),
            ListTile(
              title: Text("Add place"),
              trailing: Icon(
                Icons.add_location,
                color: Colors.deepPurple,
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addPlace()),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: null),
      body: new Container(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/img/test.jpg",
                fit: BoxFit.cover,
              ),
              const ListTile(
                leading: Icon(Icons.visibility),
                title: Text('Place1'),
                subtitle: Text('Discription of place 1 .'),
              ),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('BUY TICKETS'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    FlatButton(
                      child: const Text('Visit'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
