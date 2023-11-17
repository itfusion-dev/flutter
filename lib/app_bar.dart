import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double hue = 1.0;
    double saturation = 0.6;
    double lightness = 0.4;
    Color textColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    return AppBar(
      title: Text(
        'Logotype',
        style: GoogleFonts.montserrat(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: textColor,
              size: 36.0,
            ),
          ),
        ),
      ],
    );
  }
}
