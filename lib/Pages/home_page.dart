import 'package:finstagram/Pages/feed_page.dart';
import 'package:finstagram/Pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;

const List<Widget> _pages = <Widget>[
  FeedPage(),
  ProfilePage(),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finstagram'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'newPostpage');
                },
                icon: const Icon(Icons.add_a_photo)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (_value) {
          print(_value);
          setState(() {
            _selectedIndex = _value;
          });
        },
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
