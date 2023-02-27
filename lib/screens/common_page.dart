import 'package:flutter/material.dart';
import 'package:litsen_chat_gpt/screens/home_page.dart';
import 'package:litsen_chat_gpt/screens/talk_page.dart';
import 'package:litsen_chat_gpt/screens/bar_item_page.dart';
import 'package:litsen_chat_gpt/screens/search_page.dart';
import 'package:litsen_chat_gpt/screens/my_page.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key});

  @override
  State<CommonPage> createState() => _CommonPageState();
}

final _navBarItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.mail), label: "TalkPage"),
  // BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Messages"),
  // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];

class _CommonPageState extends State<CommonPage> {
  int _selectedIndex = 0;

  List _pages = [HomePage(), TalkPage(), BarItemPage(), SearchPage(), MyPage()];

  AppBar _appBar() {
    return AppBar(
      title: Text('Listen ChatGPT'),
    );
  }

  Drawer _drawer() {
    return Drawer();
  }

  FloatingActionButton? _floatingActionButton() {
    // if (_selectedIndex == 1) {
    //   return FloatingActionButton(
    //       child: Icon(Icons.edit),
    //       onPressed: () {
    //         print("click edit button");
    //       });
    // }else {
      return null;
    // }
  }
  
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: Colors.white,
      items: _navBarItems
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _pages[_selectedIndex], //Center(child: Text('Content')),
      drawer: _drawer(),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
