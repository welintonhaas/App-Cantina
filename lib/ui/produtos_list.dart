import 'package:flutter/material.dart';
import 'package:app_cantina/ui/produtos_page.dart';

class ProdutosList extends StatefulWidget {
  const ProdutosList({Key? key}) : super(key: key);

  @override
  ProdutosListState createState() => ProdutosListState();
}

class ProdutosListState extends State<ProdutosList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'App Cantina',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFA4A0C),
                ),
              ),
              ListTile(
                title: Text('Cadastrar Produto'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdutosPage()),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          titleSpacing: 0.0,
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.menu_sharp),
                color: Colors.black,
                onPressed: () => {
                      //Scaffold.of(context).openDrawer(),
                      if (Scaffold.of(context).isDrawerOpen)
                        {Scaffold.of(context).openEndDrawer()}
                      else
                        {Scaffold.of(context).openDrawer()}
                    }),
          ),
          elevation: 5.0,
          backgroundColor: Color(0xffffffff),
          title: Row(
            children: <Widget>[],
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Lanches Deliciosos para Você',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
