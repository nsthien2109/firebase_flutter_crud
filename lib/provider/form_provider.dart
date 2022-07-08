// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/model/task.dart';
import 'package:firebase_todo/utils/shared_prefs.dart';
import 'package:firebase_todo/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FormProvider extends ChangeNotifier{
  final _firebaseAuth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;
  //private varible
  final _textControllerA = TextEditingController();
  final _textControllerB = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Task _taskUpdate  = Task();

  
  //process access private varible
  TextEditingController get textControllerA => _textControllerA;
  TextEditingController get textControllerB => _textControllerB;
  GlobalKey<FormState> get formKey => _formKey;
  Task get taskUpdate => _taskUpdate;

  Future<void> signIn(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _textControllerA.text,
          password: _textControllerB.text,
        );
        if(credential != null){
          await setLogin('isLogin', true);
          await setKeyString('uid', credential.user!.uid);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
        EasyLoading.dismiss();
        _textControllerA.clear();
        _textControllerB.clear();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        if (e.code == 'user-not-found') {
          showTextMessage(context, 'No user found for that email.');
          return;
        } else if (e.code == 'wrong-password') {
          showTextMessage(context, 'Wrong password provided for that user');
          return;
        }
      } catch (e) {
        EasyLoading.dismiss();
        debugPrint('$e');
        return;
      }
    }
  }

  Future<void> signUp(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _textControllerA.text,
          password: _textControllerB.text,
        );
        if(credential != null){
          await setLogin('isLogin', true);
          await setKeyString('uid', credential.user!.uid);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
        EasyLoading.dismiss();
        _textControllerA.clear();
        _textControllerB.clear();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        if (e.code == 'weak-password') {
          showTextMessage(context, 'The password provided is too weak.');
          return;
        } else if (e.code == 'email-already-in-use') {
          showTextMessage(context, 'The account already exists for that email.');
          return;
        }
      } catch (e) {
        EasyLoading.dismiss();
        debugPrint('$e');
        return;
      }
    }
  }

  Future<void> addTask(context) async {
    if (_formKey.currentState!.validate()) {
      try {
          EasyLoading.showSuccess('Great Success!');
          final uid = await getKeyString('uid');
          var newTask = _database.collection('notes').doc();
          final task = Task(
            id: newTask.id,
            name: _textControllerA.text, 
            description: _textControllerB.text, 
            uid: uid ?? 'unknow'
          );
          _textControllerA.clear();
          _textControllerB.clear();
          notifyListeners();
          await newTask.set(task.toJson());
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          EasyLoading.dismiss();
         } on FirebaseAuthException catch (e) {
        if (e.code != null) {
          debugPrint(e.code);
        }
      } catch (e) {
        debugPrint('$e');
      }
    }
  }

  Future<void> signOut(context) async{
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    await FirebaseAuth.instance.signOut();
    await reset();
  }

  Future<void> deleteTask(task) async{
    EasyLoading.showSuccess('Great Success!');
    await _database.collection("notes").doc(task.id).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
    EasyLoading.dismiss();
  }

  Future<void> updatePage(context, task) async{
    _textControllerA.text = task.name;
    _textControllerB.text = task.description;
    _taskUpdate = task;
    notifyListeners();
    Navigator.pushNamed(context, '/update');
  }

  Future<void> updateTask(context) async{
    try {
      EasyLoading.showSuccess('Great Success!');
      final taskUp = Task(
      id: _taskUpdate.id,
      name: _textControllerA.text,
      description: _textControllerB.text,
      uid: _taskUpdate.uid
    );
      _textControllerA.clear();
      _textControllerB.clear();
      notifyListeners();
     Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
     await _database.collection('notes').doc(_taskUpdate.id).update(taskUp.toJson());
     EasyLoading.dismiss();
    } catch (e) {
      debugPrint('$e');
    }
  }

  Stream<List<Task>> getTasks(){
    return _database.collection('notes').where("uid",isEqualTo: _firebaseAuth.currentUser?.uid)
      .snapshots().map((snapshot) => snapshot.docs.map((e) => Task.fromJson(e.data())).toList());
  }

  @override
  void dispose() {
    _textControllerA.dispose();
    _textControllerB.dispose();
    super.dispose();
  }
}