import 'package:flutter/material.dart';
import '../../services/repository.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          bool isTrue = await MyRepository().postModel();
          print(isTrue);
          if(isTrue){
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
