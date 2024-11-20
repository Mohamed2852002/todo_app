import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/ui/home/screens/settings_screen/settings_screen.dart';
import 'package:todo_app/ui/home/screens/tasks_screen/tasks_screen.dart';
import 'package:todo_app/ui/home/widgets/task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 4.w,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            isScrollControlled: true,
            context: context,
            builder: (context) => const TaskBottomSheet(),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 36.r,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        notchMargin: 16.r,
        shape: const CircularNotchedRectangle(),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.list,
                  size: 40.r,
                ),
                label: ''),
            NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 40.r,
                ),
                label: ''),
          ],
          onDestinationSelected: (value) {
            currentPage = value;
            pageController.animateToPage(
              currentPage,
              duration: const Duration(microseconds: 1000),
              curve: Curves.linear,
            );
            setState(() {});
          },
          selectedIndex: currentPage,
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
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
