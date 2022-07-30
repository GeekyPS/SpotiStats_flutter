import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/albums_screen.dart';
import 'artists_screen.dart';

import 'songs_screen.dart';

class Global extends StatefulWidget {
  const Global({Key key}) : super(key: key);

  @override
  State<Global> createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  List<Widget> _pages = [
      ArtistsPage(),
      SongsScreen(),
      AlbumsScreen(),
    
    ];
    int _selectedPageIndex = 0;
    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }


  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        
       
        onTap: _selectPage,
        backgroundColor: Colors.black,
        enableFeedback: true,
        selectedItemColor: Color.fromARGB(255, 7, 255, 16),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        iconSize: 25,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
       unselectedLabelStyle:TextStyle(fontWeight: FontWeight.normal,fontSize: 13),
       
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Artists'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note_rounded), label: 'Tracks'),
          BottomNavigationBarItem(icon: Icon(Icons.album_outlined), label: 'Albums'),
        ],
      ),
    );
  }
}
