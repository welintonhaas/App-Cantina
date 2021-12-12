import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Variáveis.
final String tabelaProduto = "tabelaProdutos";
final String idProduto = "idProduto";
final String nome = "nome";
final String valor = "valor";
final String quantidade = "quantidade";
final String fornecedor = "fornecedor";
final String categoria = "categoria";
final String foto = "foto";

class ProdutoHelper {
  static final ProdutoHelper _instance = ProdutoHelper.internal();

  factory ProdutoHelper() => _instance;

  ProdutoHelper.internal();

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
    final path = join(databasesPath, "produtos.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaProduto($idProduto INTEGER PRIMARY KEY, $nome TEXT, $valor TEXT, $quantidade TEXT, $fornecedor TEXT, $categoria TEXT, $foto TEXT)");
    });
  }

  Future<Produto> salvarProduto(Produto produto) async {
    Database dbproduto = await db;
    produto.id = await dbproduto.insert(tabelaProduto, produto.toMap());
    return produto;
  }

  Future<Produto> buscarProduto(int id) async {
    Database dbProduto = await db;

    List<Map> maps = await dbProduto.query(tabelaProduto,
        columns: [
          idProduto,
          nome,
          valor,
          quantidade,
          fornecedor,
          categoria,
          foto
        ],
        where: "$id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Produto.fromMap(maps.first);
    } else {
      return null;
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

  Future<void> dropTable() async {
    Database dbchamado = await db;
    return await dbchamado.rawQuery("DROP TABLE IF EXISTS $tabelaProduto");
  }

  Future<void> createTable() async {
    Database dbchamado = await db;
    return await dbchamado.rawQuery(
        "CREATE TABLE $tabelaProduto($idProduto INTEGER PRIMARY KEY, $nome TEXT, $valor TEXT, $quantidade TEXT, $fornecedor TEXT, $categoria TEXT, $foto TEXT)");
  }

  Future close() async {
    Database dbProduto = await db;
    dbProduto.close();
  }
}

class Produto {
  int id;
  String nome;
  String valor;
  String quantidade;
  String fornecedor;
  String categoria;
  String foto;

  Produto(this.id, this.nome, this.valor, this.quantidade, this.fornecedor,
      this.categoria, this.foto);

  Produto.fromMap(Map map) {
    id = map[idProduto];
    nome = map[nome];
    valor = map[valor];
    quantidade = map[quantidade];
    fornecedor = map[fornecedor];
    categoria = map[categoria];
    foto = map[foto];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      idProduto: id,
      nome: nome,
      valor: valor,
      quantidade: quantidade,
      fornecedor: fornecedor,
      categoria: categoria,
      foto: foto,
    };

    if (id != null) {
      map[idProduto] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Produto (id: $id, valor: $valor, quantidade: $quantidade, fornecedor: $fornecedor, categoria: $categoria, foto: $foto";
  }
}
