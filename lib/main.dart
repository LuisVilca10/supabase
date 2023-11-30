import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase_handler.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://cwkzvacfuanjsanshtxq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3a3p2YWNmdWFuanNhbnNodHhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDEzMTE1NDIsImV4cCI6MjAxNjg4NzU0Mn0.ATVZ6Pw5uG1OXxfAd80egaVXq4JhY7kQ_ucdVf1kybs');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Supabase Flutter Demo',
      //home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // User? _user;
  late SupaBaseHandler supaBaseHandler = SupaBaseHandler();
  String newValue = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supabase-Flutter CRUD Operations"),
      ),
      body: FutureBuilder(
        future: supaBaseHandler.readData(context),
        builder: ((context, AsyncSnapshot snapshot) {
          print("here ${snapshot.data.toString()}");
          if (snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.none) {}
          print("here1 ${snapshot.data.toString()}");
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                color:
                    snapshot.data![index]['status'] ? Colors.white : Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Center(
                        child: Text(snapshot.data![index]['task']),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          supaBaseHandler.updateData(
                              snapshot.data[index]['id'], true);
                        }),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          supaBaseHandler
                              .deleteData(snapshot.data[index]['id']);
                          setState(() {});
                        }),
                  ],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    print(value);
                    newValue = value;
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  supaBaseHandler.addData(newValue, false, context);
                  setState(() {});
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
