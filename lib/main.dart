
import 'package:flutter/material.dart';
import 'package:gql_ex/query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'url.dart';

void main() {
  final HttpLink httpLink = HttpLink(url3);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  var app = GraphQLProvider(client: client, child: MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQl flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getAlbumn),
          variables: {'page': 1,'limit':7}
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List listAlbum=result.data!['albums']['data'];

          return ListView.builder(
              itemCount:listAlbum.length ,
              itemBuilder: (context,index){
            var title=listAlbum[index]['title'];
            return Container(
                width: 100,
                child:Row(
                  children: [
                    // CircleAvatar(
                    //   child: Image.network(user["albums"]["data"][index]["photos"][index]["data"]["thumbnailUrl"]),
                    // ),
                    Text(title)
                  ],
                )
            );
          });



          // List personList=result.data!['persons'];
          // print(personList);
          //  return Text(personList[1]['name']);
          // // List productList = result.data?['products']['edges'];


          // return ListView.builder(
          //   itemCount: productList.length,
          //     itemBuilder:(context,index){
          //
          //     var product=productList[index]['node'];
          //   return Container(
          //     child:Row(
          //       children: [
          //         Image.network(product['thumbnail']['url']),
          //          Text(product['name'])
          //       ],
          //     ),
          //   );
          // });
        },
      ),
    );
  }
}