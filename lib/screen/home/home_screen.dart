import 'package:firebase_todo/model/task.dart';
import 'package:firebase_todo/provider/form_provider.dart';
import 'package:firebase_todo/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Todo", 
          style: GoogleFonts.lato(
            color: Colors.white
          )
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: ()=>formProvider.signOut(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: formProvider.getTasks(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [...tasks.map((e) => TodoItem(task: e))],
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text("Some thing when wrong ${snapshot.error}"),
            );
          }else{
            return const CircularProgressIndicator();
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.pushNamed(context, '/create'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}