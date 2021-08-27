import 'package:flutter/material.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';
class Menu extends StatelessWidget {
  final Services serv;
  const Menu(this.serv) ;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (create)=>Services(this.serv.user),
      child: MenuFull(this.serv),

    );
  }
}

class MenuFull extends StatefulWidget {
  final Services serv;
  const MenuFull(this.serv) ;

  @override
  _MenuFullState createState() => _MenuFullState();
}

class _MenuFullState extends State<MenuFull> {

  @override
  Widget build(BuildContext context) {
    return  ListView(
        children:
        [
          ListTile(
            title: Text('Collections'),
            focusColor: Colors.green,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/collections',arguments: widget.serv);
            },
          ),
        ]
    );

  }
}
