import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_market/Screens/choosecategory/choosecategory.dart';
import 'package:kan_market/Screens/chooseaera/choosearea.dart';

var items=['Food','Clothes','Electronics','Cafeterias'];
var itemImg=['assets/images/food.jpeg','assets/images/clothes.jpg','assets/images/electronic.jpeg','assets/images/cafe.jpg'];

class CategoriesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width;

    PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

    List<Widget> banners = new List<Widget>();

    for (int x = 0; x < items.length; x++) {
      var bannerView = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                          spreadRadius: 1.0)
                    ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(
                  itemImg[x],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      items[x],
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                      
                    ),
                  ],
                  
                ),
              ),
              GestureDetector(
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                ChooseArea(items[x])));
                }
              )
            ],
          ),
        ),
      );
      banners.add(bannerView);
    }

    
    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
        
      
    )
    );
  }
}