import 'package:app_cantina/helpers/cliente_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();

  @override
  void initState() {
    super.initState();

    Cliente c = Cliente();

    c.nome = "Welinton Haas";
    c.email = "welinton.haas@ifsc.edu.br";

    helper.salvarCliente(c);

    helper.todosOsClientes().then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
