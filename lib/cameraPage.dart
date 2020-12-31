/*
* Christian Krueger Health LLC.
* All Rights Reserved.
*
* Author: Christian Krueger
* Date: 4.15.20
*
*/

//TODO rename this to disclaimer page
import 'package:exerciseGifLab/Models/models.dart';
import 'package:exerciseGifLab/Views/views.dart';
import 'package:exerciseGifLab/Controllers/controllers.dart';

class CameraDefines{

}

class CameraPage extends StatefulWidget {

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red,
        ),
      )
    );
  }
}