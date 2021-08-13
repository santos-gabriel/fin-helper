import 'package:finhelper/modules/home/home_controller.dart';
import 'package:finhelper/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBnb extends StatefulWidget {
  const CustomBnb({Key? key}) : super(key: key);

  @override
  _CustomBnbState createState() => _CustomBnbState();
}

class _CustomBnbState extends State<CustomBnb> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      color: AppColors.blueSoft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.setCurrentPage(0);
                });
              },
              icon: Icon(
                Icons.settings,
                color: controller.currentPage == 0
                    ? AppColors.orangeMedium
                    : AppColors.whiteSoft,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.setCurrentPage(1);
                });
              },
              icon: Icon(
                Icons.trending_up,
                color: controller.currentPage == 1
                    ? AppColors.orangeMedium
                    : AppColors.whiteSoft,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.setCurrentPage(2);
                });
              },
              icon: Icon(
                Icons.trending_down,
                color: controller.currentPage == 2
                    ? AppColors.orangeMedium
                    : AppColors.whiteSoft,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.setCurrentPage(3);
                });
              },
              icon: Icon(
                Icons.toc,
                color: controller.currentPage == 3
                    ? AppColors.orangeMedium
                    : AppColors.whiteSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
