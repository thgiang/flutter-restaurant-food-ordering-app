import 'package:flutter/material.dart';

const double s1 = 5;
const double s2 = 10;
const double s3 = 15;
const double s4 = 20;
const double s5 = 30;
const m1 = EdgeInsets.all(10);
const my1 = EdgeInsets.fromLTRB(0, s1, 0, s1);
const my2 = EdgeInsets.fromLTRB(0, s2, 0, s2);
const my3 = EdgeInsets.fromLTRB(0, s3, 0, s3);

const shadow = BoxShadow(
  color: Colors.black12,
  spreadRadius: 5,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);
