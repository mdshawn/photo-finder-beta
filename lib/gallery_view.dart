import 'package:flutter/material.dart';
import 'package:photo_finder/gallery_state.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class GalleryView extends StatelessWidget {
  String searchdata = '';

  GalleryView({required this.searchdata});

  @override
  Widget build(BuildContext context) {
    context.read<GalleryState>().load(this.searchdata);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
      ),
      body: Consumer<GalleryState>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Eg Dogs, Cats & Bananas",
                      labelText: "Enter a category",
                      contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 25.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      Future.delayed(const Duration(seconds: 1), () {
                        state.load(value);
                      });
                    },
                  ),
                ),
                state.links.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.links.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(state.links[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: OpenPhoto,
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void OpenPhoto() {
  Consumer<GalleryState>(builder: (context, value, child) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(value.links[index]),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: value.links.length),
        );
      },
      itemCount: value.links.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(),
        ),
      ),
    ));
  });
}
