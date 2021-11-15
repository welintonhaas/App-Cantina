import 'package:app_cantina/helpers/cliente_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();

  @override
  void initState() {
    super.initState();
  }

  Widget LoginPage() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Página de Login",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget CadastroPage() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Cadastro",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow() => Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logo.png',
            //fit: BoxFit.scaleDown,
            height: 200,
            alignment: Alignment.center,
          ),
        ),
      );

  Widget _createTab(String text) {
    return Tab(
      child: Row(children: [
        Expanded(
            child: Container(
          child: Center(child: Text(text)),
        )),
      ]),
    );
  }

  Widget _buildTextRow() => Expanded(
        flex: 7,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: 10),
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    _createTab('Login'),
                    _createTab('Cadastro'),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                LoginPage(),
                CadastroPage(),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return Scaffold(
      bottomSheet: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.home,
                color: Colors.red,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.search,
                color: Colors.red,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              child: Icon(
                Icons.person,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          child: Column(
            children: [
              _buildImageRow(),
              _buildTextRow(),
            ],
          )),
      backgroundColor: Colors.grey[200],
    );
  }
}
