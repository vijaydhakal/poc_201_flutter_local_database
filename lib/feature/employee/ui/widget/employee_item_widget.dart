import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poc_flutter/feature/employee/model/employee.dart';

class EmployeeItemWidget extends StatefulWidget {
  const EmployeeItemWidget(
      {super.key, required this.item, this.onDelete, this.onEdit});
  final Employee item;
  final Function? onDelete;
  final Function? onEdit;

  @override
  State<EmployeeItemWidget> createState() => _EmployeeItemWidgetState();
}

class _EmployeeItemWidgetState extends State<EmployeeItemWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            onPressed: (value) {
              widget.onDelete!();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            onPressed: (value) {
              widget.onEdit!();
            },
            backgroundColor: Color.fromARGB(255, 0, 94, 9),
            foregroundColor: Colors.white,
            icon: Icons.edit,

            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${widget.item.name}',
                style: _theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${widget.item.salary}',
                style: _theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${widget.item.salary}',
                style: _theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
