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
    GlobalKey<FormState> _formKey = new GlobalKey();
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
                icon: Icon(Icons.menu),
                iconSize: 30.0,
                color: Colors.black,
                onPressed: () => {
                      //Scaffold.of(context).openDrawer(),
                      if (Scaffold.of(context).isDrawerOpen)
                        {Scaffold.of(context).openEndDrawer()}
                      else
                        {Scaffold.of(context).openDrawer()}
                    }),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              iconSize: 30.0,
              color: Colors.black,
              onPressed: () => {},
            ),
          ],
          elevation: 0.0,
          backgroundColor: Color(0xffffffff),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Lanches \nDeliciosos para Você',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Procurar',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text('Lanche ${index + 1}'),
                          subtitle: Text('Descrição do lanche'),
                          leading: Icon(Icons.fastfood),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdutosPage()),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
