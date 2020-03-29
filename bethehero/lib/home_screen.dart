import 'package:bethehero/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <dynamic> incidents = [];
  ScrollController _scrollcontroller = new ScrollController();
  int _page = 1;
  bool _isLoading = false;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    getIncidents();

    _scrollcontroller.addListener(() async{
      if(_scrollcontroller.position.pixels == _scrollcontroller.position.maxScrollExtent){
        if(!_isLoading){
          setState(() {
            _isLoading = true;
          });
          await getIncidents();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();

    super.dispose();
  }

  Future<Null> getIncidents() async{
    http.Response response = await http.get(
      "http://192.168.0.13:3333/incidents?page=$_page",
    );

    if(response.statusCode == 200){

      setState(() {
        try{
          _total = int.parse(response.headers['x-total-count']);
        }catch(e){
          _total = 0;
          return ;
        }
      });

      if(_total != 0 && _total == incidents.length){
        setState(() {
          _isLoading = false;
        });
        return ;
      }
          
      setState(() {
        //this.incidents.add(json.decode(response.body));
        json.decode(response.body).forEach((incident)=>incidents.add(incident));
        this._isLoading = false;
        _page += 1;
      });
    }
    
  }

  Widget _homeBody(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0),
          child: Text("Bem-vindo!", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text("Escolha um dos cados abaixo e salve o dia.", style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
        ),

        Expanded(
          child: ListView.builder(
            controller: _scrollcontroller,
            itemCount: incidents.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                margin: const EdgeInsets.all(20.0),
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
                                child: Text(incidents[index]['title'], style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("ONG", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(incidents[index]['name'], style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("VALOR", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(incidents[index]['value'].toString(), style: TextStyle(color: Color.fromRGBO(115, 115, 128, 1)),),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 3.0,
                      ),
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Veja mais detalhes", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                            IconButton(
                              icon: Icon(Icons.arrow_forward, color: Colors.red,),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(incidents[index])));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
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
              child: Image.asset("images/logo.png"),
            ),

            Row(
              children: <Widget>[
                Text("total de "),
                Text(_total.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                Text(" casos"),
              ],
            ),
          ],
        )
      ),

      body: _homeBody(context),
    );
  }
}

