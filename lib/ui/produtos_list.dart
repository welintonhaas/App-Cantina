import 'package:flutter/material.dart';
import 'package:app_cantina/ui/produtos_page.dart';
import 'package:app_cantina/helpers/helper_produto.dart';

class ProdutosList extends StatefulWidget {
  const ProdutosList({Key key}) : super(key: key);

  @override
  ProdutosListState createState() => ProdutosListState();
}

class ProdutosListState extends State<ProdutosList> {
  ProdutoConnect connectProduto = ProdutoConnect();

  List<Produto> produtos = [];
  List<Produto> produtosfilter = [];

  void _addNewProduct(nome, preco, categoria, img) async {
    Produto produto = Produto();
    produto.id = null;
    produto.nome = nome;
    produto.preco = preco;
    produto.categoria = categoria;
    produto.img = img;

    produto = await connectProduto.save(produto);
  }

  @override
  void initState() {
    super.initState();

    connectProduto.dropTable();
    connectProduto.createTable();

    _addNewProduct("Xis Salada", "10,00", "Lanches",
        "https://assets.unileversolutions.com/recipes-v2/106684.jpg");
    _addNewProduct("Xis Frango", "10,00", "Lanches",
        "http://guerreirolanches.com.br/wp-content/uploads/2017/08/Xis-Franfo-com-Catupiry.jpg");
    _addNewProduct("Xis Burger", "10,00", "Lanches",
        "https://www.guiadecaxiasdosul.com/uploads/painel/imagem/1541024022102220341_m.jpg");
    _addNewProduct("Coca-Cola", "5,00", "Bebidas",
        "https://pizzariameurancho.com.br/wp-content/uploads/2018/05/coca-cola-lata-350ml-min.png");
    _addNewProduct("Fanta Laranja", "5,00", "Bebidas",
        "https://hiperideal.vteximg.com.br/arquivos/ids/185731-1000-1000/55730.jpg?v=637363918957300000");
    _addNewProduct("Misto Quente", "10,00", "Lanches",
        "https://media.istockphoto.com/photos/grilled-ham-and-cheese-sandwich-picture-id1137809307?k=20&m=1137809307&s=612x612&w=0&h=aL8XtZZozc2e39thB-ggioalSCXGdNWNP_EzzX_Rv84=");
    _addNewProduct("Cacho Quente", "10,00", "Lanches",
        "https://revistamenu.com.br/wp-content/uploads/2021/08/hotdog-estudo.jpg");

    connectProduto.getAllProdutos().then((lista) {
      setState(() {
        produtos = lista;
        produtosfilter = lista;
      });
      //print(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    GlobalKey<FormState> _formKey = new GlobalKey();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      'App Cantina',
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFA4A0C),
              ),
            ),
            ListTile(
              title: Text('Cadastrar Produto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdutosPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFEFEF),
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              iconSize: 30.0,
              color: Colors.black,
              onPressed: () => {
                    if (Scaffold.of(context).isDrawerOpen)
                      {Scaffold.of(context).openEndDrawer()}
                    else
                      {Scaffold.of(context).openDrawer()}
                  }),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () => {},
          ),
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50.0),
        child: Container(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20.0, 60, 30),
                child: Text(
                  'Lanches\nDeliciosos para Você',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        produtosfilter = produtos
                            .where((element) => element.nome
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[250],
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      labelText: 'Procurar',
                      labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300],
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: produtosfilter.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _produtosCard(context, index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        color: const Color(0xFFEFEFEF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                icon: new Icon(Icons.home),
                color: primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdutosList()),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.search,
                color: primaryColor,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.shopping_cart,
                color: primaryColor,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.person,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _produtosCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProdutosPage.produtosPage,
            arguments: produtosfilter[index]);
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 90, 10, 140),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 0,
            child: Container(
              width: 200,
              transform: Matrix4.translationValues(0.0, -60.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        topRight: Radius.circular(75),
                        bottomLeft: Radius.circular(75),
                        bottomRight: Radius.circular(75),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(produtosfilter[index].img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                produtosfilter[index].nome,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'R\$ ' + produtosfilter[index].preco,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFA4A0C),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
