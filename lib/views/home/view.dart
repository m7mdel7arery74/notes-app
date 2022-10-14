import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/add_note_dialog.dart';
import '../../widgets/note_card.dart';
import 'controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    SharedPreferences.getInstance().then((sp) {
      List<String> notes = sp.getStringList('notes') ?? [];
      for (var i in notes) {
        HomeController.instance.notes.insert(0, json.decode(i));
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: HomeController.instance.notes.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) => NoteCard(
          title: HomeController.instance.notes[index]['title'],
          note: HomeController.instance.notes[index]['note'],
          date: HomeController.instance.notes[index]['date'],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showAddNoteDialog(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}