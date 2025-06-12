import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;

  const AppDrawer({super.key, required this.theme, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.appBarTheme.backgroundColor),
            child: Text(
              'Menu',
              style: TextStyle(color: colorScheme.onPrimary, fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: colorScheme.primary),
            title: Text(
              'Home',
              style: TextStyle(
                color: colorScheme.onSurface,
                decoration:
                    currentRoute == '/home' ? TextDecoration.underline : null,
                fontWeight: currentRoute == '/home' ? FontWeight.bold : null,
              ),
            ),
            onTap: () {
              if (currentRoute != '/home') {
                Navigator.of(context).pushReplacementNamed('/home');
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.event, color: colorScheme.primary),
            title: Text(
              'Feriados',
              style: TextStyle(
                color: colorScheme.onSurface,
                decoration:
                    currentRoute == '/holiday'
                        ? TextDecoration.underline
                        : null,
                fontWeight: currentRoute == '/holiday' ? FontWeight.bold : null,
              ),
            ),
            onTap: () {
              if (currentRoute != '/holiday') {
                Navigator.of(context).pushReplacementNamed('/holiday');
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
