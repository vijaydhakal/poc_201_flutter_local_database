import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poc_flutter/feature/department/model/department.dart';

class DepartmentItemWidget extends StatefulWidget {
  const DepartmentItemWidget({super.key, required this.item, this.onDelete});
  final Department item;
  final Function? onDelete;

  @override
  State<DepartmentItemWidget> createState() => _DepartmentItemWidgetState();
}

class _DepartmentItemWidgetState extends State<DepartmentItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            onPressed: (value) {
              widget.onDelete!();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 186, 183, 183),
              ),
              child: const Icon(
                Icons.list,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.departmentName,
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
