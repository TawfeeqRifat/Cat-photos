import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String link = "https://cataas.com/cat";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: FirstPage());
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List image = [];
  //List listOfImages;
  Future fetchdata() async {
    http.Response response;
    response = await http
        .get(Uri.parse('https://cataas.com/api/cats?tags=cute&limit=100'));
    if (response.statusCode == 200) {
      setState(() {
        image = json.decode(response.body);
      });
    }
  }

  int index = 0;
  @override
  void initState() {
    fetchdata();
    //String images = image[1]['_id'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Dev'),
        ),
        body: SizedBox(
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  index++;
                  setState(() {
                    //fetchdata();
                    index++;
                    link = 'https://cataas.com/cat/${image[index]['_id']}';
                    if (index > 99) {
                      index = 0;
                    }
                  });
                },
                child: const Text('Change Image'),
              ),
              Image.network(link),
            ])));
  }
}
