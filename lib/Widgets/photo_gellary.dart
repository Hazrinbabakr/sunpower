import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryItem {
  String id;
  String image;
  GalleryItem({required this.id,required this.image});
  @override
  String toString() {
    return "id: $id";
  }
}

class PhotosGalleryPage extends StatefulWidget {
  final List<GalleryItem> galleryItems;
  final int initialPage;

  const PhotosGalleryPage({Key? key,required this.galleryItems, this.initialPage = 0})
      : super(key: key);
  @override
  _PhotosGalleryPageState createState() => _PhotosGalleryPageState();
}

class _PhotosGalleryPageState extends State<PhotosGalleryPage> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    //print(widget.initialPage);
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(widget.galleryItems[index].image),
              //initialScale: PhotoViewComputedScale.contained * 0.8,
              minScale: PhotoViewComputedScale.contained,
              // maxScale: PhotoViewComputedScale.covered * 1.1,
              heroAttributes:
              PhotoViewHeroAttributes(tag: widget.galleryItems[index].id),
            );
          },
          itemCount: widget.galleryItems.length,
          loadingBuilder: (context, progress) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              color: Colors.black,
              child: CircularProgressIndicator(
                // color: Theme.of(context).primaryColor,
                // size: 20,
              ),
            ),
          ),
          backgroundDecoration: BoxDecoration(color: Colors.black),
          pageController: pageController,
        ));
  }
}
