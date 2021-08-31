import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ritual_cafe/services/services.dart';

class ViewProduit extends StatelessWidget {
  Services serv;
 ViewProduit(this.serv);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (create)=>serv,
    child:ViewProduitFull(serv) ,
    );
  }
}
class ViewProduitFull extends StatefulWidget {
  Services serv;
   ViewProduitFull(this.serv);

  @override
  _ViewProduitFullState createState() => _ViewProduitFullState();
}
enum Tailles {S, M,L }
class _ViewProduitFullState extends State<ViewProduitFull> {
  Tailles _taille = Tailles.S;
  int priceadd = 0;
  @override
  Widget build(BuildContext context) {
   var produit = widget.serv.collections.data[widget.serv.indexCollection].produits[widget.serv.indexProduit] ;

    double width = MediaQuery .of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Container(
              height:width,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(produit.medias[0].link),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.0)
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(10.0),
                        ),
                      ),
                      width: 30,
                      height: 30,
                      child: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.arrow_back_ios, color: Colors.grey,size: 15,),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                    ),
                    ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: width,
                        decoration: BoxDecoration(
                          color: Colors.brown.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(20.0),),
                        ),
                  //    ),
                      child: Padding(padding: EdgeInsets.all(10),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(produit.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          SizedBox(height: 15,),
                          Text(produit.tags[0].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.orange,),
                              SizedBox(width: 15,),
                              Text("4,5",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(width: 15,),
                              Text("(4 566)",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                        ],
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text('Description',
              style: TextStyle(color: Colors.grey,fontSize: 15),),
            SizedBox(height: 15,),
            produit.description !=null?
            Column(
              children: [
                Text(produit.description.split('>')[1].split(';')[0],
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: produit.description.split('>')[1].split(';').length >1?
                  Row(
                    children: [
                      Container(
                        child: Text(produit.description.split('>')[1].split(';')[1],
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),),
                        width: width-150,
                      ),
                      Container( width:70,
                          child: Text('... lire plus',style: TextStyle(color: Colors.orange),))
                      ,
                    ],
                  ): Container(width: 0,height: 0,),
                )
              ],
            )
                :
            Container(width: 0,height: 0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(height: 20,),
                Text("Taille",
                  style: TextStyle(color: Colors.grey,fontSize: 15),),

                Theme(
                    data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                          ),
                        child:  RadioListTile<Tailles>(
                             dense: true,
                            activeColor: Colors.orangeAccent,
                         title: const Text('S',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )),
                      value: Tailles.S,
                      groupValue: _taille,
                      onChanged: (Tailles value) {
                        setState(() {
                          _taille = value;
                          priceadd = 0;
                        });
                      },
                    )),
                Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: RadioListTile<Tailles>(
                        activeColor: Colors.orangeAccent,
                        title: const Text('M',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )),
                        secondary:Text("+ "+produit.variants[0].options[0].additionnalFee.toString()+ " FCFA",style: TextStyle(color: Colors.orange),),
                        value: Tailles.M,
                        groupValue: _taille,
                        onChanged: (Tailles value) {
                          setState(() {
                            _taille = value;
                            priceadd = produit.variants[0].options[0].additionnalFee;
                          });
                  },
                )),
                Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: RadioListTile<Tailles>(
                      activeColor: Colors.orangeAccent,
                      title: const Text('L',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )),
                      secondary:Text("+ "+produit.variants[0].options[1].additionnalFee.toString() + " FCFA",style: TextStyle(color: Colors.orange),),
                      value: Tailles.L,
                      groupValue: _taille,
                      onChanged: (Tailles value) {
                        setState(() {
                          _taille = value;
                          priceadd = produit.variants[0].options[1].additionnalFee;
                        });
                  },
                )),

                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Prix",
                      style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text((produit.price+priceadd).toString(),
                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(" F.CFA",
                          style: TextStyle(color: Colors.orangeAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: width-140,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Acheter Maintenant",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }


}
