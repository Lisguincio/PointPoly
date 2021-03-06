import 'package:Pointpoly/media.dart';
import 'package:Pointpoly/screens/Preparazione-2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Pointpoly/definitions.dart';
import 'package:Pointpoly/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preparazione1 extends StatefulWidget{
  Preparazione1();

  MyPreparazione1 createState() => MyPreparazione1();
  
}

class MyPreparazione1 extends State<Preparazione1>{
  TextEditingController soldi = new TextEditingController(); 

  void initState(){
    super.initState();
    //CARICAMENTO DELLE PREFERENZE
    SharedPreferences.getInstance().then((i){
      if(i.containsKey('startpoints'))
        soldi.text = i.getInt("startpoints").toString();
      else
        soldi.text = rules_cash.toString();
      });
    ////
  }

  Widget build (BuildContext context){
    //print(numplayer[5].child.toString());

    return Scaffold(
      
      appBar: AppBar(
        title:Text("Preparazione Al Gioco - 1"),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
        child:Center(
          child: Column(
            children: <Widget>[
              Image.asset(playImage),
              SizedBox(height: 20,),
              Column(
                children: <Widget>[
                  Text(
                    "CONTANTI INIZIALI",
                    style: TextStyle(
                      color: Colors.black54.withAlpha(100),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 40, 
                        icon: Icon(
                          Icons.remove_circle_outline,
                        ),
                        tooltip: "Decrementa la quantità di 100",
                        onPressed: () => soldi.text = leave(int.parse(soldi.text),100).toString()
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: TextField(
                          controller: soldi,
                          inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: rules_cash.toString(),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 40, 
                        icon: Icon(
                          Icons.add_circle_outline,
                        ),
                        tooltip: "Incrementa la quantità di 100",
                        onPressed: () => soldi.text = add(int.parse(soldi.text),100).toString()
                      )
                    ],
                  )
                ],
              )
            ]
          ),
        )
          
      ),

      bottomNavigationBar:Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child:Button(
          340,
          36,
          Colors.greenAccent.shade700,
          "AVANTI",
          (){
            startpoints = int.parse(soldi.text);
            //SALVATAGGIO DELLE PREFERENZE
            SharedPreferences.getInstance().then((i){
              i.setInt('startpoints', startpoints).then((a)=>print("STARTPOINTS salvato nelle preferenze"));
            });
            ////
            Navigator.push(context, CupertinoPageRoute(builder: (context)=> Preparazione2()));// "/Preparazione2");
          },
          tooltip:"Tap per avanzare nella preparazione"),    
      )
    );
  }
}

int leave(int x, int y){
  return x-y;
}

int add(int x, int y){
  return x+y;
}