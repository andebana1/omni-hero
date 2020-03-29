import 'dart:ui';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailPage extends StatelessWidget {
  final Map<String, dynamic> _incident;

  DetailPage(this._incident);

  void sendMail(BuildContext context) async{
    final Email email = Email(
      body: "Olá, ${_incident['name']}, esotu entrando em contato pois gostaria de ajudar no caso ${_incident['title']} com o valor de ${_incident['value']}",
      subject: _incident['title'],
      recipients: [_incident['email']],
      isHTML: false
    );

    await FlutterEmailSender.send(email).then((_){
      Fluttertoast.showToast(msg: "E-mail enviado com sucesso");
      Navigator.of(context).pop();
    });

  }

  void sendWhatsapp(BuildContext context) async{
    final message = "Olá, ${_incident['name']}, esotu entrando em contato pois gostaria de ajudar no caso ${_incident['title']} com o valor de ${_incident['value']}";
    final String url = "whatsapp://send?phone=${_incident['whatsapp']}&text=$message";

    if(await canLaunch(url)){
      launch(url).then((_){
        Fluttertoast.showToast(msg: "Whatsapp enviado com sucesso");
        Navigator.of(context).pop();
      });
    }
  }

  Widget _bodyDetail(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                margin: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("CASO", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(_incident['title'], style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("ONG", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(_incident['name'], style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("DESCRIÇÃO", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(_incident['description'], style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("VALOR", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Text(_incident['value'].toString(), style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Salve o dia!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Seja o herói desse caso.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Entre em contato", style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Whatsapp", style: TextStyle(color: Colors.white),),
                          ),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red)
                          ),
                          onPressed: () => sendWhatsapp(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("E-mail", style: TextStyle(color: Colors.white),),
                          ),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red)
                          ),
                          onPressed: () => sendMail(context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 40.0,
              child: Image.asset('images/logo.png'),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.red),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),

      body: _bodyDetail(context),
    );
  }
}