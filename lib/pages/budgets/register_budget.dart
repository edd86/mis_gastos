import 'package:flutter/material.dart';

class RegisterBudget extends StatefulWidget {
  const RegisterBudget({super.key});

  @override
  State<RegisterBudget> createState() => _RegisterBudgetState();
}

class _RegisterBudgetState extends State<RegisterBudget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .15,
          vertical: size.height * .1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
