import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoList(),
      theme: ThemeData.dark(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> gorevler = [];

  void addToDoItem(String gorev) {
    if (gorev.length > 0) {
      setState(() {
        gorevler.add(gorev);
      });
    }
  }

  void removeToDoItem(int index) {
    setState(() {
      gorevler.removeAt(index);
    });
  }

  void gonderiKaldirmaEkrani(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Bunu "${gorevler[index]}" yapıldı olarak işaratle.'),
              actions: [
                MaterialButton(
                    child: Text('İptal'),
                    onPressed: () => Navigator.of(context).pop()),
                MaterialButton(
                    child: Text('Yapıldı'),
                    onPressed: () {
                      removeToDoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  Widget buildToDoList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < gorevler.length) {
        return buildToDoItem(gorevler[index], index);
      }
    });
  }

  Widget buildToDoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () {
        gonderiKaldirmaEkrani(index);
      },
    );
  }
  void gorevGir() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Yeni bir görev ekle')),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              addToDoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: 'Bir görev gir',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo')),
      body: buildToDoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: gorevGir,
          tooltip: 'Görev Ekle',
          child: Icon(Icons.add)),
    );
  }

  
}
