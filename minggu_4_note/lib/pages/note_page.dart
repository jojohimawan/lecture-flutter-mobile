import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:minggu_4_note/database/note_database.dart';
import 'package:minggu_4_note/models/note.dart';
import 'package:minggu_4_note/pages/add_edit_note_page.dart';
import 'package:minggu_4_note/pages/note_detail_page.dart';
import 'package:minggu_4_note/widgets/note_card_widget.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> _notes;
  var _isLoading = false;

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });

    _notes = await NoteDatabase.instance.getAllNotes();
    debugPrint('fetch notes true');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // final note = Note(
          //   isImportant: false,
          //   number: 1,
          //   title: 'Test',
          //   description: 'Test Desc',
          //   createdTime: DateTime.now(),
          // );
          // await NoteDatabase.instance.create(note);
          await Navigator.push(context, MaterialPageRoute(builder: (context) 
          => const AddEditNotePage()));
          _refreshNotes();
        },
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _notes.isEmpty
              ? const Text('Notes Kosong')
              : MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: _notes.length,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (_, index) {
                    final note = _notes[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) 
                        => NoteDetailPage(id: note.id!)));
                        _refreshNotes();
                      },
                      child: NoteCardWidget(
                        note: note,
                        index: index
                      )
                    );
                  },
                ),
    );
  }
}
