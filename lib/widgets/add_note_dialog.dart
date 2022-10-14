import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/home/controller.dart';

Future<void> showAddNoteDialog(BuildContext context) async => showDialog(
  context: context,
  builder: (context) => _Dialog(),
);

// ignore: must_be_immutable
class _Dialog extends StatelessWidget {
  _Dialog({Key? key}) : super(key: key);

  String? title;
  String? note;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => title = value,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextField(
              onChanged: (value) => note = value,
              decoration: const InputDecoration(
                hintText: 'Note',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (title == null ||
                    title!.isEmpty ||
                    note == null ||
                    note!.isEmpty) {
                  return;
                }
                final sp = await SharedPreferences.getInstance();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                HomeController.instance.notes.insert(0, {
                  'title': title,
                  'note': note,
                  'date': DateTime.now().toString(),
                });
                List<String> data = [];
                for (var i in HomeController.instance.notes) {
                  data.add(json.encode(i));
                }
                sp.setStringList('notes', data);
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}