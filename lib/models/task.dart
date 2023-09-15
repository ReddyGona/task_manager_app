// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  bool? isDone;
  bool? isDeleted;
  bool? isFavourite;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isDone,
    this.isDeleted,
    this.isFavourite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavourite = isFavourite ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? createdAt,
    bool? isDone,
    bool? isDeleted,
    bool? isFavourite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavourite': isFavourite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isFavourite:
          map['isFavourite'] != null ? map['isFavourite'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        description,
        isDone,
        isDeleted,
        isFavourite,
      ];
}
