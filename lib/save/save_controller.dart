import 'package:get/get.dart';

class SaveController extends GetxController {
  var selectedTab = 'audio'.obs;

  final audios = [
    {
      "title": "Wiper",
      "duration": "10.00",
      "image": "assets/car.png",
      "tags": ["#Ambition", "#Inspiration", "#Motivitioanal"],
    }
  ];

  final quotes = [
    {
      "background": "assets/quote_page_top.png",
      "text": "Just one small positive thought in the morning can change your whole day.",
      "author": "Dalai Lama",
      "tags": ["#Ambition", "#Inspiration", "#Motivitioanal"],
    }
  ];
}
