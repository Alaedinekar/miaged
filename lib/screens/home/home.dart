import 'package:flutter/material.dart';
import 'package:miaage/screens/home/panier.dart';
import 'package:miaage/screens/home/profile.dart';
import 'package:miaage/services/auth.dart';
import 'package:miaage/services/database.dart';
import 'vetementlist.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final DatabaseService _db = DatabaseService();

  int _selectedIndex = 0;
  List<Widget> screens = [ Vetementlist(),Panier(),Profile()];

  Future loadData() async {
    var vetement = _db.getVetements();
    print('home');
    print(vetement);
  }

  @override
  Widget build(BuildContext context) {
//StreamProvider.value(
//         value: DatabaseService().vetements,
//         initialData: [],
//         child:
    return Scaffold(
      backgroundColor: Colors.brown[50],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._selectedIndex,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        unselectedLabelStyle: TextStyle(fontStyle: FontStyle.italic),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Acheter",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Panier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          )
        ],
        onTap: (index) {
          setState(() => this._selectedIndex = index);
        },

        selectedItemColor: Colors.amber[800],

      ),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Text("MIAGED"),
        ),
        //title: Text('MIAGED',),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signout();
              },
              icon: Icon(Icons.person),
              label: Text('Se deconnecter'))
        ],
      ),
      body: screens[this._selectedIndex]
    );
  }
}


