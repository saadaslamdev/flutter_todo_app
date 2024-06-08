import 'package:flutter/material.dart';
import 'package:todo_app/cubits/player_cubit.dart';

class SideMenu extends StatefulWidget {
  PlayerCubit playerCubit;
  SideMenu({super.key, required this.playerCubit});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      width: screenSize.width * 0.6,
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(screenSize.width * 0.035),
          width: double.infinity,
          height: screenSize.height * 0.15,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
              child: Text('To Do App',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenSize.width * 0.05))),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(screenSize.width * 0.03),
            child: Row(
              children: [
                const Icon(Icons.person),
                SizedBox(width: screenSize.width * 0.03),
                Text('About me', style: TextStyle(fontSize: screenSize.width * 0.035))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(screenSize.width * 0.03),
            child: Row(
              children: [
                const Icon(Icons.contact_mail_rounded),
                SizedBox(width: screenSize.width * 0.03),
                Text('Contat me', style: TextStyle(fontSize: screenSize.width * 0.035))
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(screenSize.width * 0.03),
          child: Row(
            children: [
              Text('Dark Mode', style: TextStyle(fontSize: screenSize.width * 0.035)),
              SizedBox(width: screenSize.width * 0.03),
              Switch(
                  value: widget.playerCubit.state.isDarkMode,
                  onChanged: (_) {
                    widget.playerCubit.toggleTheme();
                  })
            ],
          ),
        )
      ]),
    );
  }
}
