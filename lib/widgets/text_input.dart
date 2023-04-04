import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final bool isSuffixReq;
  late bool isSecureText;
  final TextInputType inputType;
  AppTextInput({
    Key? key,
    this.hint,
    this.isSuffixReq = false,
    this.controller,
    this.isSecureText = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: widget.inputType,
        obscureText: widget.isSecureText,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hint,
            // fillColor: AppColors.PRIMARY_GREY.withOpacity(0.5),
            filled: true,
            isDense: true,
            suffixIcon: widget.isSuffixReq
                ? IconButton(
                    icon: widget.isSecureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.isSecureText = !widget.isSecureText;
                      });
                    },
                  )
                : SizedBox(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.PRIMARY_GREY),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.PRIMARY_GREY),
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}

class SearchTextInput extends StatefulWidget {
  final TextEditingController? searchController;
  final Function(String? v)? onChanged;
  const SearchTextInput({Key? key, this.searchController, this.onChanged}) : super(key: key);

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          hintText: 'search',
          fillColor: AppColors.PRIMARY_WHITE.withOpacity(0.5),
          filled: true,
          isDense: true,
          prefixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

class ChatTextInput extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onPressed;
  final Function()? emojiTapped;
  final Function()? onCameraTapped;

  const ChatTextInput({Key? key, required this.controller, this.onPressed, this.emojiTapped, this.onCameraTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey.withOpacity(0.7),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: emojiTapped,
                icon: Icon(Icons.emoji_emotions_rounded, color: AppColors.PRIMARY_WHITE.withOpacity(0.7)),
              ),
              border: InputBorder.none,
              hintText: "Message",
              hintTextDirection: TextDirection.ltr,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(onTap: onCameraTapped, child: Icon(Icons.camera_alt, color: AppColors.PRIMARY_WHITE.withOpacity(0.7), size: 20)),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.send, color: AppColors.PRIMARY_WHITE.withOpacity(0.7), size: 20),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
