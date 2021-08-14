import 'package:finhelper/src/shared/components/custom_fab/custom_fab_controller.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  const CustomFab({Key? key}) : super(key: key);

  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  CustomFabController controller = CustomFabController();
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 50.0;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: AppColors.orangeDark,
      end: AppColors.orangeDark,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!controller.isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      bool opened = controller.isOpened;
      controller.setisOpened(!opened);
    });
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Receitas',
        child: Icon(
          Icons.trending_up,
          color: AppColors.whiteSoft,
        ),
        mini: true,
      ),
    );
  }

  Widget image() {
    return new Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Despesas',
        mini: true,
        child: Icon(
          Icons.trending_down,
          color: AppColors.whiteSoft,
        ),
      ),
    );
  }

  List<Widget> buttonsForToggle() {
    if (controller.isOpened) {
      return [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 8.0,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: image(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
        ),
        toggle(),
      ];
    } else {
      return [
        toggle(),
      ];
    }
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
        color: AppColors.whiteSoft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buttonsForToggle(),
    );
  }
}
