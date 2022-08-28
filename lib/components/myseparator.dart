import 'package:flutter/material.dart';

class separator extends StatelessWidget {
  const separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.red[400],
        height: 0.5,
      ),
    );
  }
}
