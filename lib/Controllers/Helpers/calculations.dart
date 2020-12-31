/*
* Christian Krueger Health LLC.
* All Rights Reserved.
*
* Author: Christian Krueger
* Date: 4.15.20
*
*/
import 'package:exerciseGifLab/Views/views.dart';
import 'package:exerciseGifLab/Models/models.dart';

class Calculations{
  static Random rng = Random();
  static Uuid uuid = Uuid();

  static String getUuid(){
    return uuid.v4();
  }

  static double getHealthyWeight({double cm, double inches, double bmi = 23.5}){
    if(inches == null){
      inches = 63;
    }

    if(cm != null){
      inches = cmToInches(cm);
    }

    return bmi * (inches * inches) / 703;
  }

  static double getBMI({double inches, double cm, double lbs, double kg}){
    if(inches == null){
      inches = 63;
    }

    if(cm != null){
      inches = cmToInches(cm);
    }

    if(lbs == null){
      lbs = 175;
    }

    if(kg != null){
      lbs = kgToLbs(kg);
    }

    return lbs/(inches * inches) * 703;
  }


  static double weightToDailyDeficit(double kg){
    return (kgToLbs(kg) * 3500) / 7;
  }

  static double dailyDeficitToWeight(double cals){
    return lbsToKg(cals * 7 / 3500);
  }

  static double macroToPercent({
    @required double cals,
    double fat,
    double carb,
    double prot,
  }){
    if(fat != null) return (fat * 9) / cals * 100;
    if(carb != null) return (carb * 4) / cals * 100;
    if(prot != null) return (prot * 4) / cals * 100;

    return 0;
  }

  static double macroToCals(double fat, double carb, double prot, {double alc = 0}){
    return fat * 9 + carb * 4 + prot * 4 + alc * 7;
  }

  static double lbsToKg(double lbs){
    return lbs / 2.205;
  }

  static double kgToLbs(double kg){
    return kg * 2.205;
  }

  static double inchesToCm(double inches){
    return inches * 2.54;
  }

  static double cmToInches(double cm){
    return cm / 2.54;
  }



  static int decimalTimeToSeconds(int decimal){
    int time = 0;
    int temp;

    if(decimal >= 10000){
      temp = (decimal ~/ 10000);
      time += temp * 60 * 60;
      decimal -= temp * 10000;
    }
    if(decimal >= 100){
      temp = (decimal ~/ 100);
      time += temp * 60;
      decimal -= temp * 100;
    }
    if(decimal >= 1){
      temp = (decimal ~/ 1);
      time += temp;
      decimal -= temp * 1;
    }

    return time;
  }

  static DateTime getTopOfTheMonth({DateTime day}){
    if(day == null){
      day = DateTime.now();
    }

    return DateTime(
      day.year,
      day.month,
      1,
    );
  }

  static DateTime getEndOfTheMonth({DateTime day}){
    if(day == null){
      day = DateTime.now();
    }

    day = DateTime(
      day.year,
      day.month + 1
    );

    day = day.subtract(Duration(hours: 1));

    return getEOD(day: day);
  }

  static DateTime getTopOfTheWeek({DateTime day}){
    if(day == null){
      day = DateTime.now();
    }

    if(day.weekday != 7){
      day = day.subtract(Duration(days: day.weekday));
    }

    return DateTime(
      day.year,
      day.month,
      day.day,
    );
  }

  static DateTime getTopOfTheMorning({DateTime day}){
    if(day == null){
      day = DateTime.now();
    }

    return DateTime(
      day.year,
      day.month,
      day.day,
    );
  }

  static DateTime getEOD({DateTime day}){
    if(day == null){
      day = DateTime.now();
    }

    return DateTime(
      day.year,
      day.month,
      day.day,
      23,
      59,
      59,
    );
  }

  //2ft is the shortest
  //13ft is the tallest
  static double heightFromIndex(int index, bool prefersMetric){
    if(prefersMetric){
      return index + 60.0; //just under 2ft
    } else {
      return inchesToCm(index + 2 * 12.0); //2ft
    }
  }
}
