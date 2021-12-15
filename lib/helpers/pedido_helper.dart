import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
final String idPedido = "id";
final String horaEntradaPedido = "horaEntrada";
final String horaSaidaPedido = "horaSaida";
final String statusPedido = "status";
final String tabelaPedido = "tabelaPedido";

class PedidoHelper {
  static final PedidoHelper _instance = PedidoHelper.internal();

  factory PedidoHelper() => _instance;

  PedidoHelper.internal();

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

    final path = join(databasesPath, "Pedido.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaPedido($idPedido INTEGER PRIMARY KEY, $horaEntradaPedido TEXT, $horaSaidaPedido TEXT, $statusPedido TEXT)");
    });
  }

  Future<Pedido> salvarPedido(Pedido pedido) async {
    Database dbpedido = await db;

    pedido.id = await dbpedido.insert(tabelaPedido, pedido.toMap());
    return pedido;
  }

  Future<Pedido> buscarPedido(int id) async {
    Database dbPedido = await db;

    List<Map> maps = await dbPedido.query(tabelaPedido,
        columns: [idPedido, horaEntradaPedido, horaSaidaPedido, statusPedido],
        where: "$id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Pedido.fromMap(maps.first);
    } else {
      return Pedido();
    }
  }

  Future<int> deletarPedido(int id) async {
    Database dbPedido = await db;
    return await dbPedido
        .delete(tabelaPedido, where: "$idPedido=?", whereArgs: [idPedido]);
  }

  Future<int> atualizarPedido(Pedido pedido) async {
    Database dbPedido = await db;
    return await dbPedido.update(tabelaPedido, pedido.toMap(),
        where: "$idPedido = ?", whereArgs: [pedido.id]);
  }

  Future<List> todosOsClientes() async {
    Database dbCliente = await db;
    List listaMap = await dbCliente.rawQuery("SELECT * FROM $tabelaPedido");
    List<Pedido> listaPedido = [];

    for (Map m in listaMap) {
      listaPedido.add(Pedido.fromMap(m));
    }

    return listaPedido;
  }

  Future<int> getTotal() async {
    Database dbPedido = await db;
    List listaMap =
        await dbPedido.rawQuery("SELECT COUNT(*) FROM $tabelaPedido");
    return listaMap[0]["COUNT(*)"];
  }

  Future close() async {
    Database dbPedido = await db;
    dbPedido.close();
  }
}

class Pedido {
  int id = 0;
  String horaEntrada = "";
  String horaSaida = "";
  String status = "";

  Pedido();

  Pedido.fromMap(Map map) {
    id = map[idPedido];
    horaEntrada = map[horaEntradaPedido];
    horaSaida = map[horaSaidaPedido];
    status = map[statusPedido];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      horaEntradaPedido: horaEntrada,
      horaSaidaPedido: horaSaida,
      statusPedido: status,
    };

    if (id != null) {
      map[idPedido] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Pedido (id: $id, Hora Entrada: $horaEntrada, Hora Saida: $horaSaida, Status: $status)";
  }
}
