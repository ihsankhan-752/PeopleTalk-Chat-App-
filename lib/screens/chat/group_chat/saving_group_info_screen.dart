import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopletalk/screens/dashboard/home/home_screen.dart';
import 'package:peopletalk/services/firestore_services.dart';
import 'package:peopletalk/utils/show_custom_message.dart';
import 'package:peopletalk/widgets/buttons.dart';
import 'package:peopletalk/widgets/navigations.dart';
import 'package:provider/provider.dart';

import '../../../controllers/image_pick_controller.dart';
import '../../../widgets/text_input.dart';

class SavingGroupInformationScreen extends StatefulWidget {
  final List<dynamic> userIdList;
  const SavingGroupInformationScreen({Key? key, required this.userIdList}) : super(key: key);

  @override
  State<SavingGroupInformationScreen> createState() => _SavingGroupInformationScreenState();
}

class _SavingGroupInformationScreenState extends State<SavingGroupInformationScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImagePickingController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        provider.selectedImage == null
                            ? CircleAvatar(
                                radius: 45,
                                child: Icon(Icons.camera),
                              )
                            : CircleAvatar(
                                radius: 45,
                                backgroundImage: FileImage(File(provider.selectedImage!.path)),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 3,
                          child: InkWell(
                              onTap: () {
                                provider.uploadImage(ImageSource.gallery);
                              },
                              child: Icon(Icons.camera, color: Colors.teal)),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    AppTextInput(controller: titleController, hint: "Group Title"),
                    AppTextInput(controller: descController, hint: "Group Description"),
                    SizedBox(height: 20),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await FireStoreServices().creatingGroupInformationCollection(
                                  context: context,
                                  titleController: titleController.text,
                                  descController: descController.text,
                                  userIdList: widget.userIdList,
                                  selectedImage: provider.selectedImage,
                                );

                                setState(() {
                                  isLoading = false;
                                  titleController.clear();
                                  descController.clear();
                                });
                                showCustomMessage(context, "Group is Created Successfully");
                                navigateWithPush(context, HomeScreen());
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                showCustomMessage(context, e.toString());
                              }
                            },
                            title: "Create",
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
