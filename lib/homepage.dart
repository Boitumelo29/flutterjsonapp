import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterjsonapp/models/model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Character> characters = [];
// we use the future because we are fetching from the api and it can be delayed
  Future getTeams() async {
    var response =
        await http.get(Uri.https('rickandmortyapi.com', 'api/character'));
    print("my call ${response.body}");

    var jsonData = jsonDecode(response.body);

    for (var char in jsonData['results']) {
      final chart = Character(
          name: char['name'], species: char['species'], image: char['image']);
      characters.add(chart);
    }

    print("my other calll===========${characters.length}");
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      body: FutureBuilder(
          future: getTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(characters[index].image),
                    title: Text(characters[index].name),
                    subtitle: Text(characters[index].species),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

// here is an example from the documantion on how to create a reponse
//Example: var uri = Uri.https('example.org', '/path', {'q': 'dart'});
//print(uri); // https://example.org/path?q=dart
