import 'package:get/get.dart';

class SoundModel {
  final String title;
  final String imagePath;
  final List<String> tags;
  final String views;

  SoundModel({
    required this.title,
    required this.imagePath,
    required this.tags,
    required this.views,
  });
}

class SoundController extends GetxController {
  var sounds = <SoundModel>[
    SoundModel(
      title: "Wiper",
      imagePath: "assets/car.png",
      tags: ["Ambition", "Inspiration", "Motivitioanal"],
      views: "567.57k",
    ),
    SoundModel(
      title: "Wiper",
      imagePath: "assets/car.png",
      tags: ["Ambition", "Inspiration", "Motivitioanal"],
      views: "567.57k",
    ),
    SoundModel(
      title: "Wiper",
      imagePath: "assets/car.png",
      tags: ["Ambition", "Inspiration", "Motivitioanal"],
      views: "567.57k",
    ),
  ].obs;
}
