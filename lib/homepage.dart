import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

// we use the future because we are fetching from the api and it can be delayed
  Future getTeams() async {
    var response =
        await http.get(Uri.https('api.balldontlie.io', 'io/v1/teams'));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold();
  }
}


// here is an example from the documantion on how to create a reponse 
//Example: var uri = Uri.https('example.org', '/path', {'q': 'dart'});
//print(uri); // https://example.org/path?q=dart