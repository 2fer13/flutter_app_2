import 'package:flutter/material.dart';
import 'package:flutter_application_2/user_model.dart';
import 'package:flutter_application_2/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService _service = UserService();
  List<Data> users = [];
  List<Data> sonuc = [];
  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
        });
      }
    });
  }

  bool aramaYapliyorMu = false;
  void arama(String value) {
    value.contains(aramaSonucu);
  }

  late String aramaSonucu;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: aramaYapliyorMu
              ? TextField(
                  decoration: const InputDecoration(
                      hintText: "Aramak için bir şey yazın"),
                  onChanged: (aramaSonucu) {
                    print("Arama sonucu : $aramaSonucu");
                  },
                )
              : const Text("Appbar Arama"),
          actions: [
            if (aramaYapliyorMu == true)
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    arama(aramaSonucu);
                    aramaYapliyorMu = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    aramaYapliyorMu = true;
                  });
                },
              )
          ],
        ),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].firstName! + users[index].lastName!),
                subtitle: Text(users[index].email!),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(users[index].avatar!),
                ),
              );
            }),
      ),
    );
  }
}
