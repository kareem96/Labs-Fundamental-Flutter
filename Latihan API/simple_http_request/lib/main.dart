import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_http_request/model/album.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  Future<Album> fetchAlbum() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if(response.statusCode == 200){
      return Album.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: _futureAlbum,
          builder: (context, snapshot){
            var state = snapshot.connectionState;
            if(state != ConnectionState.done){
              return Center(child: CircularProgressIndicator(),);
            }else{
              if(snapshot.hasData){
                return Text(snapshot.data!.title);
              }else if(snapshot.hasError){
                return Center(child: Text('${snapshot.error}'),);
              }else{
                return Text('');
              }
            }
          },
        )
      ),
    );
  }
}



