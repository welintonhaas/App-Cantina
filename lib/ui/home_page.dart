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
      padding: new EdgeInsets.all(50.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor preencha seu e-mail';
                }
                return null;
              },
            ),
            Divider(),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor preencha a senha';
                }
                return null;
              },
            ),
            Divider(),
            RaisedButton(
              child: Text('Logar'),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
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
          child: Center(
              child: Text(text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: 10),
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  padding: EdgeInsets.only(top: 22, right: 50, left: 50),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                  ),
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
