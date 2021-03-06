import 'dart:io';

import 'package:finhelper/src/shared/auth/auth_controller.dart';
import 'package:finhelper/src/shared/database/DBProvider.dart';
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

  savePhoto(int idUser) async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String pathStr = path.path;
    final File fileDelete = File('$pathStr/user_$idUser.png');
    try {
      if (await fileDelete.exists()) {
        await fileDelete.delete();
      }
      await image!.saveTo('$pathStr/user_$idUser.png');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = LoginController();
    final AuthController authController = AuthController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteMedium,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: ((MediaQuery.of(context).size.height * 70) / 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(AppImages.logoFull),
                ),
                Container(
                  child: Text.rich(
                    TextSpan(
                        text: 'Estamos quase l??... \n',
                        style: AppTextStyles.titlePagesBlack,
                        children: [
                          TextSpan(
                            text: 'Adicione uma foto sua \n',
                            style: AppTextStyles.buttonGray,
                          ),
                          TextSpan(
                            text: 'Caso n??o queira, apenas siga em frente ',
                            style: AppTextStyles.buttonGray,
                          ),
                        ]),
                  ),
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: 68,
                      width: 68,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: Image.file(File(image!.path)).image),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: ((MediaQuery.of(context).size.height * 30) / 100),
            child: Padding(
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
                        await DBProvider.db.createAll();
                        await DBProvider.db.clearAll();
                        var idUser = await DBProvider.db.newUser(widget.user);
                        UserModel newUser = widget.user.copyWith(id: idUser);
                        await authController.saveUser(newUser);
                        await savePhoto(idUser);
                        Navigator.pushReplacementNamed(context, "/home",
                            arguments: newUser);
                      },
                      child: Icon(
                        Icons.arrow_right_alt_sharp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
