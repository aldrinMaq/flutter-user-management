import 'package:flutter/material.dart';
import 'officers.dart'; // Ensure OfficerPage is imported

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Update the sections here
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Newsfeed', style: TextStyle(fontSize: 24)),
    Text('QR Generator', style: TextStyle(fontSize: 24)),
    Text('Map', style: TextStyle(fontSize: 24)),
    OfficerPage(), // Display OfficerPage when "Users" is clicked
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use SafeArea to avoid overlapping with system UI
      body: SafeArea(
        child: SingleChildScrollView(
          // Allow scrolling if content overflows
          child: Container(
            height: MediaQuery.of(context).size.height -
                kBottomNavigationBarHeight, // Subtract nav bar height
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ),
      ),
      // BottomAppBar with custom background color
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 20, 17, 201), // Custom color
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent, // Transparent over BottomAppBar
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Newsfeed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR Generator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Users',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
