import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
const String idItemPedido = "id";
const String pedidoIdItemPedido = "pedidoId";
const String produtoIdItemPedido = "produtoId";
const String quantidadeItemPedido = "quantidade";
const String valorTotalItemItemPedido = "valorTotalItem";
const String tabelaItemPedido = "ItemPedido";

class ItemPedidoHelper {
  static final ItemPedidoHelper _instance = ItemPedidoHelper.internal();

  factory ItemPedidoHelper() => _instance;

  ItemPedidoHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "ItemPedidos.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaItemPedido($idItemPedido INTEGER PRIMARY KEY,  $pedidoIdItemPedido INTEGER, $produtoIdItemPedido INTEGER, $quantidadeItemPedido INTEGER, $valorTotalItemItemPedido DOUBLE)");
    });
  }

  Future<ItemPedido> save(ItemPedido ItemPedido) async {
    Database dbItemPedido = await db;

    ItemPedido.id =
        await dbItemPedido.insert(tabelaItemPedido, ItemPedido.toMap());
    return ItemPedido;
  }

  Future<ItemPedido> buscarItemPedido(int id) async {
    Database dbItemPedido = await db;

    List<Map> maps = await dbItemPedido.query(tabelaItemPedido,
        columns: [
          idItemPedido,
          pedidoIdItemPedido,
          produtoIdItemPedido,
          quantidadeItemPedido,
          valorTotalItemItemPedido
        ],
        where: "$idItemPedido = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return ItemPedido.fromMap(maps.first);
    } else {
      return ItemPedido();
    }
  }

  Future<int> deletarItemPedido(int id) async {
    Database dbItemPedido = await db;
    return await dbItemPedido.delete(tabelaItemPedido,
        where: "$idItemPedido=?", whereArgs: [idItemPedido]);
  }

  Future<int> atualizarItemPedido(ItemPedido ItemPedido) async {
    Database dbItemPedido = await db;
    return await dbItemPedido.update(tabelaItemPedido, ItemPedido.toMap(),
        where: "$idItemPedido = ?", whereArgs: [ItemPedido.id]);
  }

  Future<List> todosOsItensPedido(int id) async {
    Database dbItemPedido = await db;
    List listaMap = await dbItemPedido.query(tabelaItemPedido,
        columns: [
          idItemPedido,
          pedidoIdItemPedido,
          produtoIdItemPedido,
          quantidadeItemPedido,
          valorTotalItemItemPedido
        ],
        where: "$pedidoIdItemPedido = ?",
        whereArgs: [id]);
    List<ItemPedido> listaItemPedido = [];

    for (Map m in listaMap) {
      listaItemPedido.add(ItemPedido.fromMap(m));
    }

    return listaItemPedido;
  }

  Future<int> getTotal() async {
    Database dbItemPedido = await db;
    List listaMap =
        await dbItemPedido.rawQuery("SELECT COUNT(*) FROM $tabelaItemPedido");
    return listaMap[0]["COUNT(*)"];
  }

  Future close() async {
    Database dbItemPedido = await db;
    dbItemPedido.close();
  }
}

class ItemPedido {
  int id = 0;
  int pedidoId = 0;
  int produtoId = 0;
  int quantidade = 0;
  double valorTotalItem = 0.0;

  ItemPedido();

  ItemPedido.fromMap(Map map) {
    id = map[id];
    pedidoId = map[pedidoIdItemPedido];
    produtoId = map[produtoIdItemPedido];
    quantidade = map[quantidadeItemPedido];
    valorTotalItem = map[valorTotalItemItemPedido];
  }

  Map toMap() {
    Map<dynamic, dynamic> map = {
      pedidoIdItemPedido: pedidoId,
      produtoIdItemPedido: produtoId,
      quantidadeItemPedido: quantidade,
      valorTotalItemItemPedido: valorTotalItem,
    };

    if (id != null) {
      map[idItemPedido] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "ItemPedido (id: $id, pedido Id: $pedidoId, produto Id: $produtoId, quantidade: $quantidade, valor Total do Item: $valorTotalItem)";
  }
}
