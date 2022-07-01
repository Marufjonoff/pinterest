import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {

  Object object = Object();
  String name = "Obidjon";
  String email = "@marufjonovobidjon91@gmail.com";
  int followers = 12;
  int followings = 17;

  final defaultImage = [
    "https://www.idlewp.com/wp-content/uploads/2022/01/mbappe-wallpaper-idlewp-8.jpg",
    "https://en.psg.fr/media/205889/_aur6900_2021041874312637.jpg?quality=60&width=1600&bgcolor=ffffff",
    "https://s.france24.com/media/display/a072959c-f13c-11ea-8b23-005056a964fe/w:1280/p:1x1/e884c0f2650c1a9df97b6ffe8187707054934a71.jpg",
    "https://image.winudf.com/v2/image1/Y29tLnppdm1lZGlhLm1iYXBwZS53YWxscGFwZXJfc2NyZWVuXzBfMTU3NjI3MjI2OF8wMDI/screen-0.jpg?fakeurl=1&type=.jpg"
  ];

  Future <void> refresh()async {}

}