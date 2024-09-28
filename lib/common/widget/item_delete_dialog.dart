import 'package:flutter/material.dart';

class ItemDeleteDialog extends StatelessWidget {
  const ItemDeleteDialog(
      {super.key, required this.onTrue, required this.isLoading});
  final void Function(bool?)? onTrue;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onTrue!(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
