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

  Widget _buildImageRow() => Expanded(
        flex: 8,
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
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: Container(
                child: Center(child: Text(text)),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))))),
      ]),
    );
  }

  Widget _buildTextRow() => Expanded(
        flex: 2,
        child: Container(
          width: 250,
          margin: const EdgeInsets.only(top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Login',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Cadastro',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
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
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildImageRow(),
              _buildTextRow(),
            ],
          )),
      backgroundColor: Colors.grey[200],
    );
  }
}
