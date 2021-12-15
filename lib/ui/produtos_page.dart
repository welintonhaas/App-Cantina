import 'package:flutter/material.dart';
import 'package:app_cantina/ui/produtos_list.dart';
import 'package:app_cantina/ui/pedido.dart';
import 'package:app_cantina/helpers/helper_produto.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key key}) : super(key: key);

  static const produtosPage = '/produtos';

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  Produto produto;

  ProdutoConnect connectProduto = ProdutoConnect();

  void initState() {
    super.initState();
  }

  _buttom(String texto) {
    return Container(
      child: ElevatedButton(
        child: Text(texto,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            PedidoPage.pedidoPage,
            arguments: produto.id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      produto = args;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFEFEFEF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(125),
                      topRight: Radius.circular(125),
                      bottomLeft: Radius.circular(125),
                      bottomRight: Radius.circular(125),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(produto.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  produto.nome,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'R\$ ${produto.preco}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ]),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 40, 0, 0),
                  child: Text(
                    "Ingredientes",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    width: 250.0,
                    child: Column(
                      children: [
                        Text(
                          "Pão Brioche, tomate, alface, queijo mussarela, hamburguer de costela 160g,  maionese e geléia de morango",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 40, 0, 0),
                  child: Text(
                    "Informações de retirada ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: SizedBox(
                    width: 250.0,
                    child: Text(
                      "Para o correto ponto da carne, o hamburger precisa ser preparado no mínimo 30 minutos com antecedêncida, pense nisso antes de realizar seu pedido.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buttom("Adicionar ao Pedido")],
                )),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,
        color: const Color(0xFFEFEFEF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                icon: new Icon(Icons.home),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
