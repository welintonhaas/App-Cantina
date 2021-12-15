import 'package:app_cantina/helpers/itens_pedido_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_cantina/helpers/pedido_helper.dart';
import 'package:app_cantina/helpers/helper_produto.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key key}) : super(key: key);

  static const pedidoPage = '/pedido';

  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<PedidoPage> {
  ItemPedidoHelper itemPedidoHelper = ItemPedidoHelper();
  PedidoHelper pedidoHelper = PedidoHelper();
  ProdutoConnect produtoHelper = ProdutoConnect();

  List<ItemPedido> itensPedido = [];
  List<ItemPedido> todosItensPedido = [];
  Future<Pedido> pedidoCriado;
  Pedido pedido;
  Produto produto;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      produto = args;
    }

    //Criar um novo pedido
    _salvarPedido() async {
      if (pedidoHelper.buscarPedido(1) == null) {
        Pedido pedido = Pedido();
        pedido.id = null;
        pedido.horaEntrada = DateTime.now().toString();
        pedido.horaSaida = "00:00:00";
        pedido.status = 'Aberto';
        pedidoCriado = pedidoHelper.salvarPedido(pedido);
        return pedidoCriado;
      }
      return 0;
    }

    //Salvar produto na tabela de itens do pedido
    _salvarItemPedido(pedidoId) {
      if (pedidoId == null) {
        pedidoHelper.buscarPedido(1);
      } else {
        ItemPedido itemPedido = ItemPedido();
        itemPedido.id = null;
        itemPedido.produtoId = produto.id;
        itemPedido.quantidade = 1;
        itemPedido.valorTotalItem = 0.0;
        itemPedido.pedidoId = pedidoId;
        itemPedidoHelper.save(itemPedido);
      }

      itemPedidoHelper.todosOsItensPedido(pedidoId).then((list) {
        setState(() {
          todosItensPedido = list;
        });
      });
    }

    print(produto);

    /* pedidoCriado = _salvarPedido();
    pedidoCriado.then((pedido) {
      _salvarItemPedido(pedido.id);
    }); */

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
      body: Container(
          /* 
        color: const Color(0xFFEFEFEF),
        child: Column(
          children: <Widget>[
            Container(
                child: ListView.builder(
                  itemCount: itensPedido.length,
                    itemBuilder: (BuildContext context, int index) {
                Row(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(75),
                            topRight: Radius.circular(75),
                            bottomLeft: Radius.circular(75),
                            bottomRight: Radius.circular(75),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              produtoHelper.getProduto(itensPedido.index).then(
                          (value) {
                            return value.img;
                          }),
                            fit: BoxFit.cover,
                          ),
                        ),
          
                      )),
                  ],
                ),;
                ),
                Container(
                  height: 50,
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  height: 50,
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            )),
          ],
        ), */
          ),
    );
  }
}
