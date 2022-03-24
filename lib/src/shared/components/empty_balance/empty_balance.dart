import 'package:flutter/material.dart';

import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';

class EmptyBalance extends StatefulWidget {
  final int? secondsDelayed;
  const EmptyBalance({
    Key? key,
    this.secondsDelayed,
  }) : super(key: key);

  @override
  State<EmptyBalance> createState() => _EmptyBalanceState();
}

class _EmptyBalanceState extends State<EmptyBalance> {
  getDelay() async {
    await Future.delayed(Duration(seconds: widget.secondsDelayed!));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.secondsDelayed != null) {
      return FutureBuilder(
          future: getDelay(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    Image.asset(AppImages.emptyBalance),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'Nada por aqui...',
                        style: AppTextStyles.titleEmptyBalance,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          });
    } else {
      return Container(
        child: Column(
          children: [
            Image.asset(AppImages.emptyBalance),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'Nada por aqui...',
                style: AppTextStyles.titleEmptyBalance,
              ),
            ),
          ],
        ),
      );
    }
  }
}
