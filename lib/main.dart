import 'package:counter_with_bloc/bloc/todo_bloc.dart';
import 'package:counter_with_bloc/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Colors.lightBlue,
          onPrimary: Colors.black,
          secondary: Colors.greenAccent,
          onSecondary: Colors.black,
        ),
      ),
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: HomeScreen(),
      ),

    );
  }
}
