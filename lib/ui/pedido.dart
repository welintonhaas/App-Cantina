import 'package:app_cantina/helpers/itens_pedido_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_cantina/ui/produtos_page.dart';
import 'package:app_cantina/helpers/pedido_helper.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key key}) : super(key: key);

  static const pedidoPage = '/pedido';

  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<PedidoPage> {
  ItemPedidoHelper itemPedidoHelper = ItemPedidoHelper();
  PedidoHelper pedidoHelper = PedidoHelper();

  int produtoId;
  List<ItemPedido> itensPedido = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      produtoId = args;
    }

    //Criar um novo pedido
    Future _salvarPedido() async {
      if (pedidoHelper.buscarPedido(1) == null) {
        Future<Pedido> idPedido;
        Pedido pedido = Pedido();
        pedido.id = null;
        pedido.horaEntrada = DateTime.now().toString();
        pedido.horaSaida = "00:00:00";
        pedido.status = 'Aberto';
        idPedido = pedidoHelper.salvarPedido(pedido);
        return idPedido;
      }
    }

    //Salvar produto na tabela de itens do pedido
    void _salvarItemPedido(pedidoId) {
      if (pedidoId == null) {
        pedidoHelper.buscarPedido(1);
      } else {
        ItemPedido itemPedido = ItemPedido();
        itemPedido.id = null;
        itemPedido.produtoId = produtoId;
        itemPedido.quantidade = 1;
        itemPedido.valorTotalItem = 0.0;
        itemPedido.pedidoId = pedidoId;
        itemPedidoHelper.save(itemPedido);
      }
    }

    Future<dynamic> pedido = _salvarPedido();
    pedido.then((value) {
      _salvarItemPedido(value.id);
    });

    print(produtoId);

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
        color: const Color(0xFFEFEFEF),
        child: Column(
          children: <Widget>[
            Container(),
          ],
        ),
      ),
    );
  }
}
