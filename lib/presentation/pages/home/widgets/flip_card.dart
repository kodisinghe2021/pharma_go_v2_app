import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

Widget customflipCard({
  required Widget front,
  required Widget back,
}) =>
    FlipCard(
      
      front: front,
      back: back,
    );
