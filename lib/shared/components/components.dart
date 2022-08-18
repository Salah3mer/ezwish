import 'package:bee/shared/style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navegatTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navegatToAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget myFormField({
  required TextEditingController controller,
  String? label,
  String? hint,
  String? Function(String?)? validate,
  void Function()? onTap,
  String? Function(String?)? onChange,
  String? Function(String?)? onSubmit,
  void Function()? suffixOnPressed,
  TextInputType? type,
  IconData? prefix,
  Widget? suffix,
  TextStyle? style,
  bool nonFocseBorder = false,
  int? maxleanth,
  bool autofocus = false,
  Color? myColor,
  bool readonly = false,
  Color? labelColor,
  Color prefixColor = defColor,
  bool isPassword = false,
  bool isNumber = true,
  Color? suffixColor ,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Material(
          borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            elevation:isNumber?0:1,
        child: TextFormField(
          readOnly: readonly,
          controller: controller,
          validator: validate,
          onTap: onTap,
          keyboardType: type,
          obscureText: isPassword,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          style: style,
          autofocus: autofocus,
          maxLength: maxleanth,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            fillColor: myColor ?? Colors.grey[100],
            filled: true,
            labelText: label,
            hintText: hint,
            labelStyle: TextStyle(color: labelColor),
            floatingLabelStyle: TextStyle(color: labelColor ??defColor),
            prefixIcon: Icon(
              prefix,
              color: prefixColor,
            ),
            suffixIcon: suffix != null
                ? Container(
              height: 60,
                  child: suffixColor!=null?Material(
              elevation: 2.0,
              color: suffixColor,
              shadowColor: suffixColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
              ),
                    child: IconButton(
                        onPressed: suffixOnPressed,
                        icon: suffix,
                      ),
                  ):IconButton(
                    onPressed: suffixOnPressed,
                    icon: suffix,
                  ),
                )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: !nonFocseBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: defColor,
                    ),
                  )
                : UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
          ),
        ),
      ),
    );

Widget defaultButton(  {String? text, void Function()? function,IconData? icon}) => Container(
  width: double.infinity,
  height: 60,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.indigo,
          Colors.indigo.shade400,
        ]),
  ),
  child: MaterialButton(
    onPressed: function,
    minWidth: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       if (icon!=null)
         Icon(icon),
        Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
  ),
);

Future<bool?> myToast({
  required String mas,
  required Color color,
}) =>
    Fluttertoast.showToast(
      msg: mas,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget cachedImage(String image, ImageWidgetBuilder widget) =>
    CachedNetworkImage(
      placeholder: (context, url) =>
          const Center(child:  CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: widget,
      imageUrl: image,
    );
