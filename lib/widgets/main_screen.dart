import 'package:flutter/material.dart';
import 'package:todo_app/cubits/player_cubit.dart';
import 'package:todo_app/widgets/add_text.dart';
import 'package:todo_app/widgets/side_menu.dart';

class MainScreen extends StatefulWidget {
  PlayerCubit playerCubit;
  MainScreen({super.key, required this.playerCubit});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data1 = {
      "name": "Saad",
      "age": 22,
      "city": "Karachi",
      "country": "Pakistan",
    };
    Map<String, dynamic> data2 = {
      "name": "Adnan",
      "age": 25,
      "city": "New York",
      "country": "USA",
    };

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        drawer: SideMenu(playerCubit: widget.playerCubit),
        appBar: AppBar(
          centerTitle: true,
          title: Text('To Do App',
              style: TextStyle(fontSize: screenSize.width * 0.065)),
        ),
        floatingActionButton: SizedBox(
          height: screenSize.width * 0.10,
          width: screenSize.width * 0.10,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              _addNote();
            },
            tooltip: 'Add a Todo',
            child: Icon(Icons.add, size: screenSize.width * 0.05),
          ),
        ),
        body: widget.playerCubit.state.notes.isNotEmpty
            ? ListView.builder(
                itemCount: widget.playerCubit.state.notes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _deleteNote(index);
                    },
                    child: Dismissible(
                      key: Key(widget.playerCubit.state.notes[index]),
                      background: Container(
                        color: Colors.green,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.035),
                          child: const Icon(Icons.done, color: Colors.white),
                        ),
                      ),
                      onDismissed: (direction) {
                        widget.playerCubit.deleteNote(index);
                      },
                      direction: DismissDirection.startToEnd,
                      child: ListTile(
                        title: Text(widget.playerCubit.state.notes[index],
                            style:
                                TextStyle(fontSize: screenSize.width * 0.045)),
                      ),
                    ),
                  );
                })
            : Center(
                child: Text('No items in your todo list',
                    style: TextStyle(fontSize: screenSize.width * 0.045))));
  }

  void _addNote() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.035),
              height: MediaQuery.of(context).size.height * 0.22,
              child: AddText(onAddNote: widget.playerCubit.addNote),
            ),
          );
        });
  }

  void _deleteNote(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete this Item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.playerCubit.deleteNote(index);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
