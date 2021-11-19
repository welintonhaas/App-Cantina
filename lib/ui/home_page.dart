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
    const primaryColor = Color(0xFFFA4A0C);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'Por favor preencha seu e-mail';
              }
              return null;
            },
          ),
          const Divider(color: Colors.transparent),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'Por favor preencha a senha';
              }
              return null;
            },
          ),
          const Divider(
            height: 35,
            color: Colors.transparent,
          ),
          const Text('Recuperar Senha',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left),
          const Divider(
            height: 30,
            color: Colors.transparent,
          ),
          ElevatedButton(
            child: const Text('Logar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }

  Widget CadastroPage() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
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
            height: 180,
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16))),
        )),
      ]),
    );
  }

  Widget _buildTextRow(Color primaryColor) => Expanded(
        flex: 7,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                margin: const EdgeInsets.only(top: 10),
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  padding: const EdgeInsets.only(top: 22, right: 50, left: 50),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: primaryColor,
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
    const primaryColor = Color(0xFFFA4A0C);
    return //Scaffold(
        /*bottomSheet: Container(
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
                color: primaryColor,
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
      ),*/
        Container(
            padding: const EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                _buildImageRow(),
                _buildTextRow(primaryColor),
              ],
            ));
  }
}
