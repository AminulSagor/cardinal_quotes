import 'package:cardinal/journal/journal_view.dart';
import 'package:cardinal/note_writing/note_writing_view.dart';
import 'package:cardinal/quote/quote_view.dart';
import 'package:cardinal/save/save_view.dart';
import 'package:cardinal/sleep_sound/sleep_sound_view.dart';
import 'package:cardinal/sound/sound_list_view.dart';
import 'package:cardinal/todo/todo_view.dart';
import 'package:flutter/material.dart';

import '../home/home_view.dart';


class AppRoutes {
  static const String home = '/';
  static const String soundList = '/sound-list';
  static const String sleepSound = '/sleep-sound';
  static const String todo = '/todo';
  static const String quote = '/quote';
  static const String save = '/save';
  static const String journal = '/journal';
  static const String noteWriting = '/note-writing';

  static Map<String, WidgetBuilder> get routes => {
    home: (_) => HomeView(),
    soundList: (_) => SoundListView(),
    sleepSound: (_) => SleepSoundView(),
    todo: (_) => TodoView(),
    quote: (_) => QuoteView(),
    save: (_) => SaveView(),
    journal: (_) => JournalView(),
    noteWriting: (_) => NoteWritingView(),
  };
}
