import 'package:flutter/material.dart';

class Destinations {
  IconData iconSelected;
  String label;
  IconData icon;

  Destinations({
    required this.iconSelected,
    required this.label,
    required this.icon,
  });

  static List<Destinations> destinations = [
    Destinations(
      iconSelected: Icons.home_outlined,
      label: 'Inicio',
      icon: Icons.home,
    ),
    Destinations(
      iconSelected: Icons.money,
      label: 'Ingresos',
      icon: Icons.money_outlined,
    ),
  ];
}
