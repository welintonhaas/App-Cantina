//import 'package:app_cantina/helpers/cliente_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyCad = new GlobalKey();
  // ClienteHelper helper = ClienteHelper();

  @override
  void initState() {
    super.initState();
  }

  Widget loginPage() {
    const primaryColor = Color(0xFFFA4A0C);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          children: [
            Form(
              key: _formKey,
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
                    validator: (value) {
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
                    validator: (value) {
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
                      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _sendForm,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendForm() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, '/produtos_list');
    }
  }

  Widget cadastroPage() {
    const primaryColor = Color(0xFFFA4A0C);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKeyCad,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (arg) {
                      if (arg == null || arg.isEmpty) {
                        return 'Preencha um nome';
                      } else
                        return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor preencha seu e-mail';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor preencha a senha';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
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
                  ElevatedButton(
                    child: const Text('Cadastrar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _sendFormCad,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendFormCad() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, '/cadatrar');
    }
  }

  Widget _buildImageRow() => Expanded(
        flex: 3,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Image.asset(
              'assets/logo.png',
              //fit: BoxFit.scaleDown,
              height: 180,
              alignment: Alignment.center,
            ),
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

  Widget _buildTextRow() => Expanded(
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
                        color: Color(0xFFFA4A0C),
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
                loginPage(),
                cadastroPage(),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const primaryColor = Color(0xFFFA4A0C);
    return Container(
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
          Expanded(
            child: Column(children: [
              _buildImageRow(),
              _buildTextRow(),
            ]),
          ),
        ],
      ),
    );
  }
}
