import 'package:flutter/material.dart';

BackgroundImageDecoration(String imageUrl, {fit = BoxFit.cover, opacity=0.2}){
  return BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(imageUrl),
    fit: fit,
    opacity: 0.2
    )
  );
}