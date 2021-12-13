import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tabelaProdutos = "tabelaProdutos";
final String idProduto = "idProduto";
final String nomeProduto = "nomeProduto";
final String categoriaProduto = "categoriaProduto";
final String precoProduto = "precoProduto";
final String imgProduto = "imgProduto";

class ProdutoConnect {
  static final ProdutoConnect _instance = ProdutoConnect.internal();

  factory ProdutoConnect() => _instance;

  ProdutoConnect.internal();

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
    final path = join(databasesPath, "Produtos.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tabelaProdutos($idProduto INTEGER PRIMARY KEY, $nomeProduto TEXT,"
          "$categoriaProduto TEXT, $precoProduto TEXT, $imgProduto TEXT)");
    });
  }

  Future<Produto> save(Produto produto) async {
    Database dbProduto = await db;
    produto.id = await dbProduto.insert(tabelaProdutos, produto.toMap());
    return produto;
  }

  Future<Produto> getProdutosByName(String nome) async {
    Database dbProduto = await db;
    List<Map> maps = await dbProduto.query(tabelaProdutos,
        columns: [
          idProduto,
          nomeProduto,
          categoriaProduto,
          precoProduto,
          imgProduto
        ],
        where: "$nomeProduto = ?",
        whereArgs: [nome]);
    if (maps.length > 0) {
      return Produto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Produto> getProduto(int id) async {
    Database dbProduto = await db;
    List<Map> maps = await dbProduto.query(tabelaProdutos,
        columns: [
          idProduto,
          nomeProduto,
          categoriaProduto,
          precoProduto,
          imgProduto,
        ],
        where: "$idProduto = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Produto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteProduto(int id) async {
    Database dbProduto = await db;
    return await dbProduto
        .delete(tabelaProdutos, where: "$idProduto = ?", whereArgs: [id]);
  }

  Future<int> update(Produto Produto) async {
    Database dbProduto = await db;
    return await dbProduto.update(tabelaProdutos, Produto.toMap(),
        where: "$idProduto = ?", whereArgs: [Produto.id]);
  }

  Future<List> getAllProdutos() async {
    Database dbProduto = await db;
    List listMap = await dbProduto.rawQuery('SELECT * FROM $tabelaProdutos');

    List<Produto> listProduto = [];

    for (Map m in listMap) {
      listProduto.add(Produto.fromMap(m));
    }
    return listProduto;
  }

  Future dropTable() async {
    Database dbProduto = await db;
    dbProduto.execute("DROP TABLE $tabelaProdutos");
  }

  Future createTable() async {
    Database dbProduto = await db;
    dbProduto.execute(
        "CREATE TABLE $tabelaProdutos($idProduto INTEGER PRIMARY KEY, $nomeProduto TEXT,"
        "$categoriaProduto TEXT, $precoProduto TEXT, $imgProduto TEXT)");
  }

  Future<int> getNumber() async {
    Database dbProduto = await db;
    return Sqflite.firstIntValue(
        await dbProduto.rawQuery("SELECT COUNT(*) FROM $tabelaProdutos"));
  }

  Future close() async {
    Database dbProduto = await db;
    dbProduto.close();
  }
}

class Produto {
  int id;
  String nome;
  String categoria;
  String preco;
  String img;

  Produto();

  //Construtor - quando formos armazenar em nosso bd, vamos armazenar em
  //um formato de mapa e para recuperar os dados, precisamos transformar
  //esse map de volta em nosso contato.
  Produto.fromMap(Map map) {
    // nessa função eu pego um map e passo para o meu contato
    id = map[idProduto];
    nome = map[nomeProduto];
    categoria = map[categoriaProduto];
    preco = map[precoProduto];
    img = map[imgProduto];
  }

  Map toMap() {
    // aqui eu pego contato e transformo em um map
    Map<String, dynamic> map = {
      nomeProduto: nome,
      categoriaProduto: categoria,
      precoProduto: preco,
      imgProduto: img,
    };

    if (id != null) {
      map[idProduto] = id;
    }
    return map;
  }

  @override
  String toString() {
    //sobrescrita do método para facilitar a visualização dos dados
    return "Produto(id: $id, nome: $nome, categoria: $categoria, preco: $preco, img: $img )";
  }
}
