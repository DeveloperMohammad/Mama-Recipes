import 'package:flutter/material.dart';
import 'package:mama_recipes/screens/bottom_navigation_bar_screen.dart';
import 'package:mama_recipes/screens/filter_screen.dart';

//! my own classes
import '../screens/settings_screen.dart';
import '../screens/about_us_screen.dart';
import '../widgets/change_theme_button_widget.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          // shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Home Page button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const BottomNavigationBarScreen(
                            index: 0,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    label: const Text('صفحه اصلی'),
                  ),
                  const Divider(thickness: 1),
                  //! Filter Screen
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(FilterScreen.routeName);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    label: const Text('جستجوی پیشرفته'),
                  ),
                  const Divider(thickness: 1),
                  //! Favorites Page button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const BottomNavigationBarScreen(
                            index: 1,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    label: const Text('مورد علاقه ها'),
                  ),
                  const Divider(thickness: 1),
                  //! About Us Page button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AboutUsScreen.routeName);
                    },
                    icon: Icon(
                      Icons.info,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    label: const Text('در مورد ما'),
                  ),
                  const Divider(thickness: 1),
                  //! Settings Page button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    label: const Text('تنظیمات'),
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Row(
                      children: const [
                        Text('حالت شب'),
                        ChangeThemeButtonWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
