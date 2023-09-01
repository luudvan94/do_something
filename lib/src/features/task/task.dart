// create Task model with id, name
import 'dart:math';

import 'package:do_something/src/features/task/rating.dart';
import 'package:flutter/material.dart';

class Task {
  final String id;
  final String name;
  final Rating rating;

  // constructor
  Task({
    required this.id,
    required this.name,
    this.rating = Rating.neutral,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
    );
  }
}
