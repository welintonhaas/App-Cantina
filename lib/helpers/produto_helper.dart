import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

// Variáveis
final String idProduto = "id";
final String nome = "nome";
final String valor = "valor";
final String quantidade = "qtd";
final String fornecedor = "fornecedor";
final String categoria = "categoria";
final String tabelaProduto = "tabelaProduto";

class ProdutoHelper {
  static final ProdutoHelper _instance = ProdutoHelper.internal();

  factory ProdutoHelper() => _instance;

  ProdutoHelper.internal();

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

    final path = join(databasesPath, "Produto.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaProduto(id INTEGER PRIMARY KEY, nome TEXT, valor DOUBLE, qtd TEXT, fornecedor TEXT, categoria TEXT)");
    });
  }

  Future<Produto> salvarProduto(Produto cliente) async {
    Database dbcliente = await db;

    cliente.id = await dbcliente.insert(tabelaProduto, cliente.toMap());
    return cliente;
  }

  Future<Produto> buscarProduto(int id) async {
    Database dbProduto = await db;

    List<Map> maps = await dbProduto.query(tabelaProduto,
        columns: [idProduto, nome, valor, quantidade, fornecedor, categoria],
        where: "$id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Produto.fromMap(maps.first);
    } else {
      return Produto();
    }
  }

  Future<int> deletarProduto(int id) async {
    Database dbProduto = await db;
    return await dbProduto
        .delete(tabelaProduto, where: "$idProduto=?", whereArgs: [idProduto]);
  }

  Future<int> atualizaProduto(Produto produto) async {
    Database dbProduto = await db;
    return await dbProduto.update(tabelaProduto, produto.toMap(),
        where: "$idProduto = ?", whereArgs: [produto.id]);
  }

  Future<List> todosOsProdutos() async {
    Database dbProduto = await db;
    List listaMap = await dbProduto.rawQuery("SELECT * FROM $tabelaProduto");
    List<Produto> listaProduto = [];

    for (Map m in listaMap) {
      listaProduto.add(Produto.fromMap(m));
    }

    return listaProduto;
  }

  Future<int> getTotal() async {
    Database dbProduto = await db;
    return Sqflite.firstIntValue(
        await dbProduto.rawQuery("SELECT COUNT(*) FROM $tabelaProduto"));
  }

  Future close() async {
    Database dbProduto = await db;
    dbProduto.close();
  }
}

class Produto {
  int id = 0;
  String nome = "";
  String valor = "";
  String quantidade = "";
  String fornecedor = "";
  String categoria = "";

  Produto();

  Produto.fromMap(Map map) {
    id = map[id];
    nome = map[nome];
    valor = map[valor];
    quantidade = map[quantidade];
    fornecedor = map[fornecedor];
    categoria = map[categoria];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nome: nome,
      valor: valor,
      quantidade: quantidade,
      fornecedor: fornecedor,
      categoria: categoria,
    };

    if (id != null) {
      map[idProduto] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Cliente (id: $id, valor: $valor, quantidade: $quantidade, fornecedor: $fornecedor, categoria: $categoria";
  }
}
