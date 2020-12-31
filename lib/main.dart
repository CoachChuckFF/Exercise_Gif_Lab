import 'package:exerciseGifLab/Views/views.dart';
import 'package:exerciseGifLab/Models/models.dart';
import 'package:exerciseGifLab/Controllers/controllers.dart';
import 'package:exerciseGifLab/cameraPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ExerciseGifLab());
}

class ExerciseGifLab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise Gif Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CameraPage(),
    );
  }
}
