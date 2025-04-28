import 'package:flutter/material.dart';
import 'package:news/views/newsScreen.dart';
import 'package:provider/provider.dart';
import 'viewmodels/newsViewModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel()..fetchNews(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News App',
        theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: Colors.tealAccent,
            secondary: Colors.teal,
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            elevation: 2,
          ),
          cardColor: Colors.grey[850],
        ),
        home: NewsScreen(),
      ),
    );
  }
}
