import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/non_ui/providers/auth_provider.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';

class IndexPage extends StatefulWidget {
  final int index;
  const IndexPage({this.index});
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //Initialize Page controller
  PageController _pageController;
  int _currentIndex;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.index ?? 0,
    );
    _currentIndex = widget.index ?? 0;
    Auth.authProvider(context).setPageController(_pageController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      HomePage(),
      TasksPage(
        title: 'All Tasks',
      ),
      TasksPage(title: 'Completed Tasks'),
    ];

    return Scaffold(
      body: PageView(
        children: children,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
