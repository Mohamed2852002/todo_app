import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/ui/home/screens/settings_screen/settings_screen.dart';
import 'package:todo_app/ui/home/screens/tasks_screen/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50.w,
        toolbarHeight: 150.h,
        title: const Text('To Do List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 65.h,
              width: 65.w,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.w,
                  color: Colors.white,
                ),
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.add,
                size: 28.r,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          currentPage = value;
          pageController.animateToPage(
            currentPage,
            duration: const Duration(microseconds: 1000),
            curve: Curves.linear,
          );
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              size: 40.r,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              size: 40.r,
            ),
            label: '',
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          currentPage = value;
          setState(() {});
        },
        children: const [
          TasksScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
