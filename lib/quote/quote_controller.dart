import 'package:get/get.dart';

class QuoteController extends GetxController {
  final quotes = <Map<String, dynamic>>[
    {
      "type": "image",
      "background": "assets/quote_page_top.png",
      "tags": ["#Ambition", "#Inspiration", "#Motivitioanal"],
    },
    {
      "type": "text",
      "text":
      "You cannot let a fear of failure or a fear of comparison or a fear of judgment stop you from doing the things that will make you great.",
      "tags": ["#Ambition", "#Inspiration", "#Motivitioanal"],
    },
    {
      "type": "text",
      "text":
      "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      "tags": ["#Success", "#Persistence", "#WinstonChurchill"],
    },
    {
      "type": "text",
      "text":
      "The only way to do great work is to love what you do.",
      "tags": ["#Work", "#Passion", "#SteveJobs"],
    },
    {
      "type": "text",
      "text":
      "Don’t watch the clock; do what it does. Keep going.",
      "tags": ["#Focus", "#Motivation", "#TimeManagement"],
    },
    {
      "type": "image",
      "background": "assets/quote_page_top.png",
      "tags": ["#Mindfulness", "#Peace", "#DalaiLama"],
    },
    {
      "type": "text",
      "text":
      "Believe you can and you're halfway there.",
      "tags": ["#Confidence", "#Belief", "#TheodoreRoosevelt"],
    },
    {
      "type": "text",
      "text":
      "It always seems impossible until it's done.",
      "tags": ["#NelsonMandela", "#Resilience", "#Hope"],
    },
  ].obs;
}
