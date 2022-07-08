import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final Color? colorButton;
  Function()? onTap;
  SubmitButton({Key? key, required this.label, this.colorButton, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width/2,
      height: 50,
      decoration: BoxDecoration(
        color: colorButton ?? Colors.orange[500]!,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(
        onPressed: onTap, 
        child: Text(label, 
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20
          )
        )
      ),
    );
  }
}