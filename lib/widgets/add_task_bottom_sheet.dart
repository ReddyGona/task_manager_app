// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatelessWidget {
  AddTaskBottomSheet({Key? key}) : super(key: key);

  TextEditingController taskTitleTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding to move bottom sheet up when keyboard is open
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _buildBodyUI(),
      ),
    );
  }

  Column _buildBodyUI() => Column(
        children: [
          TextField(
            controller: taskTitleTextEditingController,
          )
        ],
      );
}
