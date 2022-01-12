import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:photo_finder/gallery_view.dart';

void main(List<String> args) {
  runApp(SearchPage());
}

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Photo Finder",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Container(
                constraints:
                    BoxConstraints.tightFor(width: 200.0, height: 200.0),
                child: Image.network(
                  "https://image.freepik.com/free-vector/digital-search-logo-design-template_145155-3286.jpg",
                  fit: BoxFit.scaleDown,
                )),
            ListTile(
              title: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Eg Dogs, Cats & Bananas",
                  labelText: "Enter a category",
                  contentPadding:
                      const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 25.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(GalleryView());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                ),
                child: Text("Search"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
