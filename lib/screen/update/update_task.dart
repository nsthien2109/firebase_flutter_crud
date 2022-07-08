import 'package:firebase_todo/provider/form_provider.dart';
import 'package:firebase_todo/utils/validate.dart';
import 'package:firebase_todo/widgets/submit_button.dart';
import 'package:firebase_todo/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTodo extends StatelessWidget {
  const UpdateTodo();
  
  @override
    Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Update Todo"),
        titleTextStyle: const TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formProvider.formKey,
          child: Column(
            children: [
              TextInput(
                controller: formProvider.textControllerA,
                helpText: "Enter your name task",
                labelText: "Name Task",
                validate: (value)=>ValidationForm.textBoxValidate(value), 
                onChange: (value){}
              ),
              TextInput(
                controller: formProvider.textControllerB,
                helpText: "Enter your task description",
                labelText: "Task Description",
                validate: (value)=> ValidationForm.textBoxValidate(value), 
                onChange: (value){}
              ),
              SubmitButton(
                label: "Update",
                onTap: ()=> formProvider.updateTask(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
