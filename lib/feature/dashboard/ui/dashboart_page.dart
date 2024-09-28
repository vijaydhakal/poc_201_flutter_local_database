import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/widget/button/rounded_filled_button.dart';
import 'package:poc_flutter/feature/department/ui/screen/department_list_page.dart';
import 'package:poc_flutter/feature/employee/ui/screen/employee_list_page.dart';
import 'package:poc_flutter/feature/projects/ui/screen/projects_list_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Gap(20),
            RoundedFilledButton(
                textColor: Colors.white,
                onPressed: () {
                  NavigationService.push(EmployeeListPage());
                },
                verticalPadding: 20,
                title: "Employee",
                backgroundColor: Colors.black,
                borderColor: Colors.white),
            const Gap(20),
            RoundedFilledButton(
                textColor: Colors.white,
                onPressed: () {
                  NavigationService.push(ProjectsListPage());
                },
                verticalPadding: 20,
                title: "Projects",
                backgroundColor: Colors.black,
                borderColor: Colors.white),
            const Gap(20),
            RoundedFilledButton(
                textColor: Colors.white,
                onPressed: () {
                  NavigationService.push(DepartmentListPage());
                },
                verticalPadding: 20,
                title: "Departments",
                backgroundColor: Colors.black,
                borderColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
