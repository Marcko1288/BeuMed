import 'package:flutter/material.dart';
class NavLink extends StatefulWidget {
  const NavLink({super.key});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('COMING SOON ....',
        style: TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.bold
        ),
        ),
      ],
    );
  }
}
