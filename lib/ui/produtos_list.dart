import 'package:flutter/material.dart';
import 'package:app_cantina/ui/produtos_page.dart';
import 'package:app_cantina/helpers/produto_helper.dart';

class ProdutosList extends StatefulWidget {
  const ProdutosList({Key? key}) : super(key: key);

  @override
  ProdutosListState createState() => ProdutosListState();
}

class ProdutosListState extends State<ProdutosList> {
  ProdutoHelper helperProduto = ProdutoHelper();

  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();

    Produto produto = Produto();
    produto.id = 1;
    produto.nome = "Coca-Cola";
    produto.valor = "3.00";
    produto.quantidade = "10";
    produto.fornecedor = "Coca-Cola";
    produto.categoria = "Refrigerante";
    produto.foto =
        "https://freepngimg.com/thumb/coke/1-2-coca-cola-png-clipart.png";

    helperProduto.salvarProduto(produto);

    //helperProduto.todosOsProdutos().then((lista) {
    //setState(() {
    //produtos = lista;
    //});
    //print(lista);
    //});
  }

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
                      child: const Text(
                        'App Cantina',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
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
                    itemCount: produtos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _produtosCard(context, index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _produtosCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProdutosPage(
                  //produto: produtos[index],
                  )),
        );
      },
      child: Card(
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(produtos[index].foto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      produtos[index].nome,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${produtos[index].valor}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
