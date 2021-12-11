import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
const String idCliente = "id";
const String nome = "nome";
const String whatsapp = "whatsapp";
const String curso = "curso";
const String fase = "fase";
const String email = "email";
const String imagem = "imagem";
const String tabelaCliente = "tabelaCliente";

class ClienteHelper {
  ClienteHelper.internal();

  static final ClienteHelper _instance = ClienteHelper.internal();

  factory ClienteHelper() => _instance;

  late Database _db;

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

    final path = join(databasesPath, "Clientes.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaCliente(id INTEGER PRIMARY KEY, $nome TEXT, $whatsapp TEXT, $curso TEXT, $fase TEXT, $curso TEXT, $imagem TEXT)");
    });
  }

  Future<Cliente> salvarCliente(Cliente cliente) async {
    Database dbcliente = await db;

    cliente.id = await dbcliente.insert(tabelaCliente, cliente.toMap());

    return cliente;
  }

  Future<Cliente> buscarCliente(int id) async {
    Database dbCliente = await db;

    List<Map> maps = await dbCliente.query(tabelaCliente,
        columns: [idCliente, nome, whatsapp, curso, fase, email, imagem],
        where: "$id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Cliente.fromMap(maps.first);
    }

    return Cliente();
  }

  Future<int> deletarCliente(int id) async {
    Database dbCliente = await db;
    return await dbCliente
        .delete(tabelaCliente, where: "$idCliente=?", whereArgs: [idCliente]);
  }

  Future<int> atualizarCliente(Cliente cliente) async {
    Database dbCliente = await db;
    return await dbCliente.update(tabelaCliente, cliente.toMap(),
        where: "$idCliente = ?", whereArgs: [cliente.id]);
  }

  Future<List> todosOsClientes() async {
    Database dbCliente = await db;
    List listaMap = await dbCliente.rawQuery("SELECT * FROM $tabelaCliente");
    List<Cliente> listaCliente = [];

    for (Map m in listaMap) {
      listaCliente.add(Cliente.fromMap(m));
    }

    return listaCliente;
  }

  Future<int> getTotal() async {
    Database dbCliente = await db;
    return Sqflite.firstIntValue(
        await dbCliente.rawQuery("SELECT COUNT(*) FROM $tabelaCliente"));
  }

  Future close() async {
    Database dbCliente = await db;
    dbCliente.close();
  }
}

class Cliente {
  int id = 0;
  String nome = '';
  String whatsapp = '';
  String curso = '';
  String fase = '';
  String email = '';
  String imagem = '';

  Cliente() {
    this.email = email;
    this.nome = nome;
    this.whatsapp = whatsapp;
    this.curso = curso;
    this.fase = fase;
    this.imagem = imagem;
  }

  Cliente.fromMap(Map map) {
    id = map[id];
    nome = map[nome];
    whatsapp = map[whatsapp];
    curso = map[curso];
    fase = map[fase];
    email = map[email];
    imagem = map[imagem];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nome: nome,
      whatsapp: whatsapp,
      curso: curso,
      fase: fase,
      email: email,
      imagem: imagem,
    };

    if (id != null) {
      map[idCliente] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Cliente (id: $id, nome: $nome, whatsapp: $whatsapp, curso: $curso, fase: $fase, email : $email, imagem : $imagem)";
  }
}
