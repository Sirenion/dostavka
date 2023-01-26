import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({Key? key,
    required this.listImages,
  }) : super(key: key);

  final List listImages;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: false,
              height: (listImages.length == 1) ? 188.0 : 155.0,
              viewportFraction: (listImages.length == 1) ? 1 : 0.9,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: 0
          ),
          items: map<Widget>(listImages, (index, url) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SliderFullscreen(
                                listImages: listImages,
                                current: index)
                    ),
                    );
                  },
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


class SliderFullscreen extends StatelessWidget {
  const SliderFullscreen({Key? key,
    required this.listImages,
    required this.current,
  }) : super(key: key);

  final List listImages;
  final int current;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leadingWidth: 100.0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      height: MediaQuery.of(context).size.height/1.3,
                      viewportFraction: 1.0,
                      initialPage: current
                  ),
                  items: map<Widget>(listImages, (index, url) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                              height: 500.0,
                            ),
                          )
                        ]
                    );
                  }),
                ),
              ],
            )
        )
    );
  }
}

