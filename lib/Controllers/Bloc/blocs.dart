/*
* Christian Krueger Health LLC.
* All Rights Reserved.
*
* Author: Christian Krueger
* Date: 4.15.20
*
*/
import 'package:exerciseGifLab/Controllers/controllers.dart';


//--------------- Bool --------------------------------------

abstract class BoolEvent{}
class BoolUpdateEvent implements BoolEvent{
  final bool value;

  BoolUpdateEvent(this.value);
} 

class BoolToggleEvent implements BoolEvent{

  BoolToggleEvent();
} 

class BoolBLoC extends Bloc<BoolEvent, bool>{
  final bool _start;

  BoolBLoC([this._start = false]) : super(_start ?? false);

  bool get initialState => _start;


  @override
  Stream<bool> mapEventToState(BoolEvent event) async* {
    if(event is BoolUpdateEvent){

      yield event.value;
    } else if(event is BoolToggleEvent){
      yield !state;
    }
  }

  dispose()  async{
    await close();
  }
}

//----------------- Int ---------------------------------------

abstract class IntEvent{}
class IntUpdateEvent implements IntEvent{
  final int value;

  IntUpdateEvent(this.value);
} 

class IntIncrementEvent implements IntEvent{

  IntIncrementEvent();
} 

class IntBLoC extends Bloc<IntEvent, int>{
  final int _start;

  IntBLoC([this._start = 0]) : super(_start ?? 0);

  int get initialState => _start;

  @override
  Stream<int> mapEventToState(IntEvent event) async* {
    if(event is IntUpdateEvent){
      yield event.value;
    } else if(event is IntIncrementEvent){
      yield state + 1;
    }
  }

  dispose()  async{
    await close();
  }
}

//----------------- Double ---------------------------------------

abstract class DoubleEvent{}
class DoubleUpdateEvent implements DoubleEvent{
  final double value;

  DoubleUpdateEvent(this.value);
} 

class DoubleBLoC extends Bloc<DoubleEvent, double>{
  final double _start;

  DoubleBLoC([this._start = 0.0]) : super(_start ?? 0.0);

  double get initialState => _start;

  @override
  Stream<double> mapEventToState(DoubleEvent event) async* {
    if(event is DoubleUpdateEvent){
      yield event.value;
    }
  }

  dispose()  async{
    await close();
  }
}

//----------------- String ---------------------------------------

abstract class StringEvent{}
class StringUpdateEvent implements StringEvent{
  final String value;

  StringUpdateEvent(this.value);
} 

class StringBLoC extends Bloc<StringEvent, String>{
  final String _start;

  StringBLoC([this._start = ""]) : super(_start ?? '');

  String get initialState => _start;

  @override
  Stream<String> mapEventToState(StringEvent event) async* {
    if(event is StringUpdateEvent){
      yield event.value;
    }
  }

  dispose()  async{
    await close();
  }
}
