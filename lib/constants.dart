import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class constants2 {
  static const heading1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: Color.fromARGB(255, 110, 100, 4),
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 211, 190, 0),
  );
  static const heading22 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const heading4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 211, 190, 0),
  );

  static const heading42 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 110, 100, 4),
  );

  static const heading43 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 41, 37, 2),
  );

  static const heading44 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w900,
    color: Color.fromARGB(255, 31, 28, 1),
  );
  static const heading5 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const body = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: Colors.black,
  );
  static const body2 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w200,
    color: Color.fromARGB(255, 110, 100, 4),
  );
}


 isDark ? darkBgColor : lightBgColor
style: isDark ? dark.heading1 : light.heading1
isDark ? dark.iconColor : light.iconColor,
isDark
                                        ? dark.borderColor
                                        : light.borderColor,

  if (isUrdu == true) {
    } else {}


Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(50),
                          color: isDark
                              ? dark.iconBackground
                              : light.iconBackground,
                        ),
                        width: 100,
                        height: 100,
                        child: Icon(Icons.speaker_phone,
                            color: isDark ? dark.iconColor : light.iconColor,
                            size: 70)),


 appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
              color: isDark ? dark.topIconColor : light.topIconColor),
          backgroundColor: isDark ? darkBgColor : lightBgColor,
          title: Center(
            child: Text(
              'ڈیجی رسائی',
              style: isDark ? dark.heading1 : light.heading1,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout,
                  color: isDark ? dark.topIconColor : light.topIconColor),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
            )
          ],
        ),
      ),

 decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              isDark ? darkBgColor : lightBgColor,
              isDark ? darkBgColor : lightBgColor,
            ],
          ),
        ),


  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: isDark
                                        ? dark.borderColor
                                        : light.borderColor,
        child: Container(
          width: 100,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: FloatingActionButton(
              onPressed: () {
                toggleRecording();
              },
              child: Container(
                  width: 100,
                  height: 100,
                  child: Icon(isListening ? Icons.mic : Icons.mic_none,
                      color: isDark ? dark.iconColor : light.iconColor,
                      size: 50)),
              focusColor: isDark ? dark.borderColor : light.borderColor,
              backgroundColor:
                  isDark ? dark.iconBackground : light.iconBackground,
            ),
          ),
        ),
      ),