import 'package:flutter/material.dart';
class BlankPixel extends StatelessWidget {
  const BlankPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            //color:const Color(0xCCeb9b34),
            borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
