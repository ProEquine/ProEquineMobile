import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proequine/features/events/data/eventmodel.dart';
import 'package:proequine/features/events/presentation/widgets/eventitem.dart';

import '../../../../core/constants/images/app_images.dart';


class EventCarousel extends StatelessWidget {
  final List<Product> lodedProducts = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  EventCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: CarouselSlider(
      options: CarouselOptions(),
      items: lodedProducts
          .map((item) =>
      const EventItem(
        imgUrl: AppImages.upComingEvent,
        national: "UAE LONGINES",
        team: 'TEAM MASTER',
        date: '12-13 Oct',
        location: 'EEC',
      ),)
          .toList(),
    ));
  }
}
