import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // context.read<CategoryProvider>().getCategoriesHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.themeProvider.toggleTheme();
            },
            icon: Icon(
              context.themeMode == ThemeMode.light
                  ? FontAwesomeIcons.solidSun
                  : FontAwesomeIcons.solidMoon,
              color: Colors.amber,
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 10),
      ),
    );
  }
}
