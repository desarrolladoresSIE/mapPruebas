import 'package:flutter/material.dart';


class BtnMapWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  const BtnMapWidget({
    required this.icon,
    required this.onPressed,
    this.text = 'Aceptar',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.black,
        shape: const StadiumBorder(),
      ),
      onPressed:onPressed,
      icon:  Icon(icon,size: 25,),
      label:  Text(text,style:const TextStyle(fontSize: 15),),
    );
  }
}
