import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/player_cubit.dart';
import 'package:todo_app/widgets/main_screen.dart';

import 'states/player_pref.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PlayerCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PlayerCubit _playerCubit;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    var playerCubit = context.read<PlayerCubit>();
    _initPlayerCubit(playerCubit);
  }

  Future<void> _initPlayerCubit(PlayerCubit playerCubit) async {
    var playerPref = PlayerPref();
    await playerPref.init();
    playerCubit.loadData(playerPref);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _playerCubit = context.watch<PlayerCubit>();
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _playerCubit.state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : MainScreen(playerCubit: _playerCubit),
    );
  }
}
