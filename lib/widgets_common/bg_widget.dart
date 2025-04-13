import 'package:flutter/material.dart';
import 'package:emart_app/consts/images.dart'; // or wherever imgBackground is

Widget bgWidget({Widget? child}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}

