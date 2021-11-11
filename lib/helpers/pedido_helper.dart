import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
final String idPedido = "id";
final String horaEntrada = "horaEntrada";
final String horaSaida = "horaSaida";
final String status = "status";
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
          "CREATE TABLE $tabelaPedido(id INTEGER PRIMARY KEY, $horaEntrada TEXT, $horaSaida TEXT, $status TEXT)");
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
        columns: [idPedido, horaEntrada, horaSaida, status],
        where: "$id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Pedido.fromMap(maps.first);
    } else {
      return null;
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
    List<Pedido> listaPedido = List();

    for (Map m in listaMap) {
      listaPedido.add(Pedido.fromMap(m));
    }

    return listaPedido;
  }

  Future<int> getTotal() async {
    Database dbPedido = await db;
    return Sqflite.firstIntValue(
        await dbPedido.rawQuery("SELECT COUNT(*) FROM $tabelaPedido"));
  }

  Future close() async {
    Database dbPedido = await db;
    dbPedido.close();
  }
}

class Pedido {
  int id;
  String horaEntrada;
  String horaSaida;
  String status;

  Pedido();

  Pedido.fromMap(Map map) {
    id = map[id];
    horaEntrada = map[horaEntrada];
    horaSaida = map[horaSaida];
    status = map[status];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      horaEntrada: horaEntrada,
      horaSaida: horaSaida,
      status: status,
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