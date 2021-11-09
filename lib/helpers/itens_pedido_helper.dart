import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
final String idItemPedido = "id";
final String pedidoId = "pedidoId";
final String produtoId = "produtoId";
final String quantidade = "quantidade";
final String valorTotalItem = "valorTotalItem";
final String tabelaItemPedido = "ItemPedido";

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
          "CREATE TABLE $tabelaItemPedido(id INTEGER PRIMARY KEY, nome TEXT, whatsapp TEXT, curso TEXT, fase TEXT, email TEXT)");
    });
  }

  Future<ItemPedido> salvarItemPedido(ItemPedido ItemPedido) async {
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
          pedidoId,
          produtoId,
          quantidade,
          valorTotalItem
        ],
        where: "$idItemPedido = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return ItemPedido.fromMap(maps.first);
    } else {
      return null;
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
          pedidoId,
          produtoId,
          quantidade,
          valorTotalItem
        ],
        where: "$pedidoId = ?",
        whereArgs: [id]);
    List<ItemPedido> listaItemPedido = List();

    for (Map m in listaMap) {
      listaItemPedido.add(ItemPedido.fromMap(m));
    }

    return listaItemPedido;
  }

  Future<int> getTotal() async {
    Database dbItemPedido = await db;
    return Sqflite.firstIntValue(
        await dbItemPedido.rawQuery("SELECT COUNT(*) FROM $tabelaItemPedido"));
  }

  Future close() async {
    Database dbItemPedido = await db;
    dbItemPedido.close();
  }
}

class ItemPedido {
  int id;
  String pedidoId;
  String produtoId;
  String quantidade;
  String valorTotalItem;

  ItemPedido();

  ItemPedido.fromMap(Map map) {
    id = map[id];
    pedidoId = map[pedidoId];
    produtoId = map[produtoId];
    quantidade = map[quantidade];
    valorTotalItem = map[valorTotalItem];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      pedidoId: pedidoId,
      produtoId: produtoId,
      quantidade: quantidade,
      valorTotalItem: valorTotalItem,
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
