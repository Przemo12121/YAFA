import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  const StyledContainer({super.key, required this.child, this.height, this.width});

  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: const [BoxShadow(
          color: Color.fromARGB(10, 0, 0, 0), 
          spreadRadius: 3, 
          blurStyle: BlurStyle.inner,
          offset: Offset(0, 4)
        )]
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: child
    );
  }
}