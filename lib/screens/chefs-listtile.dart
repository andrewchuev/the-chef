import 'package:flutter/material.dart';
import 'package:thechef/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:thechef/widgets/app-bar.dart';
import 'package:thechef/widgets/carousel.dart';

class ChefListTile extends StatelessWidget {
  CarouselParameters parameters = CarouselParameters(url: 'https://the-chef.co/?get-chefs', circle: true, containerWidth: 170, titleAlign: Alignment.center, imageHeight: 120.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Container(
        child: FutureBuilder<List<CarouselSlide>>(
          future: fetchResponse(http.Client(), parameters.url),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage("${snapshot.data[index].image}"),
                        ),
                        title: Text(
                          snapshot.data[index].title,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                        ),
                        subtitle: Text(snapshot.data[index].description),
//                          subtitle: Text('Sub title'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
