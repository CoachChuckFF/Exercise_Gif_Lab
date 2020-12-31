/*
* Christian Krueger Health LLC
* All Rights Reserved.
*
* Author: Christian Krueger
* Date: 4.16.20
*
*/
//External
import 'package:colorize/colorize.dart';

class LOG{

  static void log(String message, int level){


    if(level > 3) return;

    Colorize preamble = Colorize("");

    switch(level){
      case 0:
        preamble = Colorize("???")..yellow();
        break;
      case 1:
        preamble = Colorize("XXX")..red();
        break;
      case 2:
        preamble = Colorize("NFO")..lightGray();
        break;
      case 3:
        preamble = Colorize("VRB")..blue();
        break;
      default: 
        preamble = Colorize("SVB")..magenta();
    }

    print("$preamble : ${DateTime.now()} ~ $message");
    
  }
}