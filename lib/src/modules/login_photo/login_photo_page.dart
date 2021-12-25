import 'dart:io';

import 'package:finhelper/src/shared/models/user_model.dart';
import 'package:finhelper/src/shared/themes/app_colors.dart';
import 'package:finhelper/src/shared/themes/app_images.dart';
import 'package:finhelper/src/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LoginPhotoPage extends StatefulWidget {
  final UserModel user;
  const LoginPhotoPage({Key? key, required this.user}) : super(key: key);

  @override
  _LoginPhotoPageState createState() => _LoginPhotoPageState();
}

class _LoginPhotoPageState extends State<LoginPhotoPage> {
  XFile? image;
  String? imageStr;

  getPhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          image = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  savePhoto() async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String pathStr = path.path;
    final File fileDelete = File('$pathStr/user.png');
    try {
      if (await fileDelete.exists()) {
        await fileDelete.delete();
      }
      await image!.saveTo('$pathStr/user.png');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = LoginController();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteMedium,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.asset(AppImages.logoFull),
                ),
              ),
              Container(
                child: Text.rich(
                  TextSpan(
                      text: 'Estamos quase lá... \n',
                      style: AppTextStyles.titlePagesBlack,
                      children: [
                        TextSpan(
                          text: 'Adicione uma foto sua \n',
                          style: AppTextStyles.buttonGray,
                        ),
                        TextSpan(
                          text: 'Caso não queira, apenas siga em frente ',
                          style: AppTextStyles.buttonGray,
                        ),
                      ]),
                ),
              ),
            ],
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: image != null
                      ? Image.file(File(image!.path)).image
                      : Image.asset(AppImages.logoFull).image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      onTap: () async {
                        getPhotoFromGallery();
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.whiteSoft,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.fromBorderSide(
                              BorderSide(color: AppColors.graySoft)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    height: 56,
                                    width: 0.5,
                                    color: AppColors.graySoft,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Adicione uma foto para seu perfil",
                                    style: AppTextStyles.titleGraySoftRegular,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                    ),
                    onPressed: () async {
                      await savePhoto();
                      Navigator.pushReplacementNamed(context, "/home",
                          arguments: widget.user);
                    },
                    child: Icon(
                      Icons.arrow_right_alt_sharp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
