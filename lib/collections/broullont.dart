import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template1_genuka_mobile/collections/collections.dart';
import 'package:template1_genuka_mobile/collections/colors.dart';
import 'package:template1_genuka_mobile/collections/pagner.dart';
import 'package:template1_genuka_mobile/models/json/collectionjson.dart';
import 'package:template1_genuka_mobile/services/services.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
 final  Services serv;
   Home(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:this.serv,
      child:HomeFull(serv) ,
    );
  }
}
class HomeFull extends StatefulWidget {
  final Services serv;
   HomeFull(this.serv);

  @override
  _HomeFullState createState() => _HomeFullState();
}

class _HomeFullState extends State<HomeFull> {
         PageController _pageController = PageController(
    initialPage:0,
    keepPage: true,
  );
  int _selectedIndex = 0;
  bool ready = true;
 
  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    if(ready)
    {setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });}
  }

  List<bool> etats =[];
  List<String> foodList =[];
  List<String> stableList =[];
  bool inSeach = false;
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
              body: PageView(
                physics: ClampingScrollPhysics(),
                onPageChanged: (index) {
                  pageChanged(index);
                },
                controller: _pageController,
                children: [
                  Collections(servs),
                  Pagner(servs),
                  Center(
                    child: Container(
                      child: Text("Compte",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text("Settings",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  //ListFormationInscri(widget.serv),
                  //ListFormationFini(widget.serv),
                  // CV(widget.user),
                ],
              ),
              bottomNavigationBar: navyBottomBar(),
            )

    );

  }
     Widget navyBottomBar() {
    return  BottomNavigationBar(
      //backgroundColor: Colors.,
      currentIndex: _selectedIndex,
      onTap: (index) {
        bottomTapped(index);
      },
      items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '',
       backgroundColor: secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: '',
        backgroundColor:  secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: '',
        backgroundColor: secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '',
             backgroundColor: secondaryColor//principalTextColor10,
        ),

      ],
      selectedItemColor: primaryColor,
      unselectedItemColor:secondaryTextColor,
    );
  }
 String createNote(List<Avis >avis){
      String note = '';
      double notes = 0;
      for(int i = 0;i<avis.length;i++){
        notes = notes + avis[i].note;
      }
      if(avis.length>0) notes = notes/avis.length;
      note = notes.toStringAsPrecision(1);
      note = note.split('.').length >1? note.split('.')[0]  + ','+note.split('.')[1] : note;
      return note;
    }
}
