// @dart=2.9
import 'package:app_cantina/ui/home_page.dart';
import 'package:app_cantina/ui/produtos_page.dart';
import 'package:app_cantina/ui/produtos_list.dart';
import 'package:app_cantina/ui/cadastrar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "App Cantina",
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Color(0xFFFA4A0C),
      scaffoldBackgroundColor: const Color(0xFFEFEFEF),

      // Define the default font family.
      fontFamily: 'Roboto',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    routes: {
      '/': (context) => HomePage(),
      '/cadastrar': (context) => CadastroPage(),
      // '/login': (context) => LoginPage(),
      '/produtos': (context) => ProdutosPage(),
      '/produtos_list': (context) => ProdutosList(),
    },
  ));
}
