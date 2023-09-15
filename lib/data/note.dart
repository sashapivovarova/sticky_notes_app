import 'package:flutter/material.dart';

class Note {
  static const colorDefault = Colors.white;

  static const colorRed = Color(0xffffd9de);

  static const colorOrange = Color(0xfffedcbf);

  static const colorYellow = Color(0xfff3e57e);

  static const colorLime = Color(0xffd5e8cf);

  static const colorBlue = Color(0xffd0e4fe);

  static const tableName = 'notes';

  static const columnId = 'id';

  static const columnTitle = 'title';

  static const columnBody = 'body';

  static const columnColor = 'color';

  final int? id;

  late final String title;

  late final String body;

  late final Color color;

  Note(this.body, {this.id, this.title = '', this.color = colorDefault});

  Note.fromRow(Map<String, dynamic> row)
      : this(
          row[columnBody],
          id: row[columnId],
          title: row[columnTitle],
          color: Color(row[columnColor]),
        );

  Map<String, dynamic> toRow() {
    return {
      columnTitle: title,
      columnBody: body,
      columnColor: color.value,
    };
  }
}
