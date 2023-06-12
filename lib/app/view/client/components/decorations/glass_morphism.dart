import 'package:flutter/material.dart';
import 'package:pharma_go_v2_app/supports/constant/colurs.dart';

BoxDecoration glassDecoration() => BoxDecoration(
      gradient: glassGrasdient(),
      border: Border.all(
        width: 1,
        color: kGlassColur,
      ),
      borderRadius: BorderRadius.circular(20),
    );
