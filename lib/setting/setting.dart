import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
 final  Services serv;
   Settings(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:SettingsFull(serv) ,
    );
  }
}
class SettingsFull extends StatefulWidget {
  final Services serv;
   SettingsFull(this.serv);

  @override
  _SettingsFullState createState() => _SettingsFullState();
}

class _SettingsFullState extends State<SettingsFull> {
  
  final rechercheController = TextEditingController();
  @override
  void dispose() {
    rechercheController.dispose();
    super.dispose();
  }
  @override
    Widget build(BuildContext context) {
    return  Consumer<Services>(
        builder: (context,servs,_)=>
          Scaffold(

              /*
              appBar: AppBar(
                title: Text(widget.serv.selectedIndex.toString()+"/"+servs.selectedIndex.toString()),
              ),
              */
              
                  backgroundColor: Colors.black,
              body: Container(
                      child: Text("Settings",style: TextStyle(color: Colors.white),),
                    )
            ));

                    

  }

}
