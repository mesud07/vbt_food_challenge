import 'package:flutter/material.dart';
import 'package:vbt_food_challange/core/theme/color/color_theme.dart';

class CustomButton extends StatefulWidget {
  late String text;
  final bool isLoading;
  final VoidCallback func;
  late Color color;
  CustomButton(
      {Key? key,
      required this.text,
      required this.isLoading,
      required this.func}) {
    color = AppColors().pompelmo;
  }

  CustomButton.googleSignIn({required this.isLoading, required this.func}) {
    text = "Google ile Giriş";
    color = AppColors().nightblue;
  }

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.color),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.83,
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.0562,
          child: (!widget.isLoading)
              ? Center(
                  child: Text(
                    widget.text,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              : Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.height * 0.035,
                    child: const CircularProgressIndicator(
                      color: Color.fromARGB(255, 212, 185, 185),
                    ),
                  ),
                ),
        ));
  }
}
