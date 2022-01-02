import 'dart:io';

import 'package:band_name_app/models/band.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Black Sabbath', votes: 5),
    BandModel(id: '2', name: 'Metallica', votes: 7),
    BandModel(id: '3', name: 'Red Hot Chilli Peppers', votes: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>
              _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  /// tile of every band
  Dismissible _bandTile(BandModel band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          print('borrado');
        }
      },
      background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2).toUpperCase()),
          backgroundColor: Colors.blue.shade100,
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isIOS) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('New Band Name'),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => addBandToList(textController.text),
                    child: const Text('Add'),
                    textColor: Colors.blue,
                    elevation: 5,
                  ),
                ],
              ));
    }

    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: const Text('New Band Name'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Add'),
                  isDefaultAction: true,
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  child: const Text('Dismiss'),
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      setState(() {
        bands.add(
            BandModel(id: DateTime.now().toString(), name: name, votes: 0));
      });
    }

    Navigator.pop(context);
  }
}
