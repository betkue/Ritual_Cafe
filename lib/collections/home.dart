import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ritual_cafe/clients/auth/auth.dart';
import 'package:ritual_cafe/collections/collections.dart';
import 'package:ritual_cafe/collections/colors.dart';
import 'package:ritual_cafe/collections/pagner.dart';
import 'package:ritual_cafe/loadding.dart';
import 'package:ritual_cafe/models/ResponseUser.dart';
import 'package:ritual_cafe/profil/profil.dart';
import 'package:ritual_cafe/services/services.dart';
import 'package:provider/provider.dart';
import 'package:ritual_cafe/setting/setting.dart';

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
  int _selectedIndex = 0;
  bool ready = true;
  void pageChanged(int index,Services servs) {
    setState(() {
      servs.selectedIndex = index;
    });
  }

  void bottomTapped(int index,Services servs,PageController _pageController) {
    if(ready)
    {setState(() {
      //_selectedIndex = index;
       servs.selectedIndex = index;
      
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
      
              PageController _pageController = PageController(
           initialPage: widget.serv.selectedIndex ,
        keepPage: true,
      );
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
                onPageChanged: (index,) {
                  pageChanged(index,servs);
                },
                controller: _pageController,
                children: [
                  Collections(servs),
                  Pagner(servs),
                  Profil(servs),
                  Settings(servs),
                  //ListFormationInscri(widget.serv),
                  //ListFormationFini(widget.serv),
                  // CV(widget.user),
                ],
              ),
              bottomNavigationBar: navyBottomBar(servs,_pageController),
            ));

                    

  }
     Widget navyBottomBar(Services servs,PageController pageController) {
    return  BottomNavigationBar(
      //backgroundColor: Colors.,
      currentIndex: servs.selectedIndex,
      onTap: (index) {
        bottomTapped(index,servs,pageController);
      },
      items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "",
        backgroundColor: secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag),
        label: "",
        backgroundColor:  secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "",
        backgroundColor: secondaryColor//principalTextColor10,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "",
        backgroundColor: secondaryColor//principalTextColor10,
        ),

      ],
      selectedItemColor: primaryColor,
      unselectedItemColor:secondaryTextColor,
    );
  }
 
}
