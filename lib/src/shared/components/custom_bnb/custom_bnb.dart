import 'package:finhelper/src/modules/home/home_controller.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBnb extends StatefulWidget {
  const CustomBnb({Key? key}) : super(key: key);

  @override
  _CustomBnbState createState() => _CustomBnbState();
}

class _CustomBnbState extends State<CustomBnb> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
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
                  controller.setCurrentPage(BodyHomePages.Extract);
                });
              },
              icon: Icon(
                Icons.toc,
                color: controller.currentPage == BodyHomePages.Extract
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
                  controller.setCurrentPage(BodyHomePages.Expanses);
                });
              },
              icon: Icon(
                Icons.trending_up,
                color: controller.currentPage == BodyHomePages.Expanses
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
                  controller.setCurrentPage(BodyHomePages.Revenues);
                });
              },
              icon: Icon(
                Icons.trending_down,
                color: controller.currentPage == BodyHomePages.Revenues
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
                  controller.setCurrentPage(BodyHomePages.Settings);
                });
              },
              icon: Icon(
                Icons.settings,
                color: controller.currentPage == BodyHomePages.Settings
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