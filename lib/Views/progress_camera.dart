// /*
// * Christian Krueger Health LLC.
// * All Rights Reserved.
// *
// * Author: Christian Krueger
// * Date: 4.15.20
// *
// */

// // Used Packages
// import 'package:foodfrenzy/Models/models.dart';
// import 'package:foodfrenzy/Controllers/controllers.dart';
// import 'package:foodfrenzy/Views/views.dart';

// class ProgressCameraDefines{
//   static int readyState = 0;
//   static int previewState = 1;
//   static int savingState = 2;
// }

// class ProgressCamera extends StatefulWidget {
//   final bool visable;
//   final double topButtonBarWidth;
//   final double topButtonBarHeight;
//   final double middleWidth;
//   final double buttonWidth;
//   final Function onExit;

//   ProgressCamera({
//     this.visable,
//     this.topButtonBarWidth,
//     this.topButtonBarHeight,
//     this.middleWidth,
//     this.buttonWidth,
//     this.onExit,
//     Key key,
//   }) : super(key: key);

//   @override
//   _ProgressCameraState createState() => _ProgressCameraState();
// }

// class _ProgressCameraState extends State<ProgressCamera> {
//   IntBLoC _cameraStateBloc = IntBLoC(ProgressCameraDefines.readyState);
//   BoolBLoC _cameraReadyBloc = BoolBLoC();
//   AuthController _auth = AuthController();
//   String _tempPath;
//   CameraController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   @override
//   void dispose() {
//     if(_controller != null) _controller.dispose();
//     _cameraReadyBloc.dispose();
//     _cameraStateBloc.dispose();
//     super.dispose();
//   }

//   Future<void> _initializeCamera() async {
//     List<CameraDescription> cameras;

//     try {
//       cameras = await availableCameras();
//       _controller = CameraController(cameras.first, ResolutionPreset.high, enableAudio: false);
//       await _controller.initialize();
//       _tempPath = (await getTemporaryDirectory()).path;
//       _cameraReadyBloc.add(BoolUpdateEvent(true));
//     } catch (e) {
//       LOG.log("Could not start camera : ${e.toString()}", FoodFrenzyDebugging.crash);
//       return;
//     }
     
//   }

//   Future<void> _swapCameras() async {
//     List<CameraDescription> cameras;
//     final lensDirection =  _controller.description.lensDirection;

//     _cameraReadyBloc.add(BoolUpdateEvent(false));

//     try {
//       cameras = await availableCameras();
//       _controller = CameraController(cameras.first, ResolutionPreset.high, enableAudio: false);
//       CameraDescription newDescription;
//       if(lensDirection == CameraLensDirection.front){
//           newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
//       }
//       else{
//           newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
//       }

//       if(newDescription != null){
//         _controller = CameraController(newDescription, ResolutionPreset.high, enableAudio: false);
//         await _controller.initialize();
//         _cameraReadyBloc.add(BoolUpdateEvent(true));
//       }
//     } catch (e) {
//       LOG.log("Could not swap camera : ${e.toString()}", FoodFrenzyDebugging.crash);
//       return;
//     }
     
//   }

//   Widget _buildLogPPTopButtonBar(){
//     return SafeArea(
//       child: Container(
//         padding: EdgeInsets.only(left: 13, right: 13),
//         width: widget.topButtonBarWidth,
//         height: widget.topButtonBarHeight,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.kitchen, color: FoodFrenzyColors.secondary.withAlpha(0)),
//               onPressed: (){}
//             ),
//             Expanded(
//               child: Center(
//                 child: AST(
//                   "Log Progress Picture", 
//                   color: FoodFrenzyColors.secondary,
//                   isBold: true,
//                   size: 21,
//                 ),
//               ),
//             ),
//             IconButton(
//               //TODO get a kg and lbs icon
//               icon: Icon(Icons.kitchen, color: FoodFrenzyColors.secondary.withAlpha(0)),
//               onPressed: (){

//               }
//             ),
//           ]
//         ),
//       ),
//     );
//   }

//   Widget _buildPPPage(){
//     User _user = _auth.getUser;

//     return UserStateView((userState){
//       bool hasReference = userState.lastPhotoDate != null;

//       return BlocBuilder(
//         cubit:_cameraReadyBloc,
//         builder: (context, cameraReady) {

//           if(!cameraReady){
//             return Center(
//               child: Loader(
//                 size: 55
//               ),
//             );
//           }

//           return LayoutBuilder(
//             builder: (context, constraints) {
//               double deviceRatio = (constraints.maxWidth / 1.1) / constraints.maxHeight;
              
//               return Center(
//                 child: Transform.scale(
//                   scale: _controller.value.aspectRatio / deviceRatio,
//                   child: Center(
//                     child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: FoodFrenzyColors.jjBlack,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: CommonAssets.shadow,
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Container(
//                             child: LayoutBuilder(
//                               builder: (context, frame) {
//                                 return BlocBuilder(
//                                   cubit:_cameraStateBloc,
//                                   builder: (context, state) {
//                                     return Stack(
//                                       children: <Widget>[
//                                         if(state == ProgressCameraDefines.readyState) CameraPreview(_controller),
//                                         if(state == ProgressCameraDefines.previewState || state == ProgressCameraDefines.savingState) Image.file(File('$_tempPath/FF_${TextHelpers.getTodaysFirebaseDate()}.png')), 
//                                         if(hasReference && state == ProgressCameraDefines.readyState)
//                                           Opacity(
//                                             opacity: 0.34,
//                                             child: FirebaseDownloader(
//                                               '${_user.uid}/${TextHelpers.datetimeToFirebaseString(userState.lastPhotoDate)}.png', 
//                                               FirebaseDownloaderDefines.progress_picture, 
//                                               placeholder: Image.asset('assets/images/photoOutline.png', width: frame.maxWidth),
//                                             ),
//                                           ),
//                                         if(!hasReference && state == ProgressCameraDefines.readyState)
//                                           Opacity(
//                                             opacity: 0.55,
//                                             child: Image.asset('assets/images/photoOutline.png', width: frame.maxWidth),
//                                           ),
//                                         if(state == ProgressCameraDefines.readyState)
//                                           Positioned(
//                                             left: (frame.maxWidth / 2) - (34/2),
//                                             bottom: 13,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 FontAwesomeIcons.cameraAlt,
//                                                 color: FoodFrenzyColors.tertiary,
//                                                 size: 34,
//                                               ), 
//                                               onPressed: () async{
//                                                 String picPath = '$_tempPath/FF_${TextHelpers.getTodaysFirebaseDate()}.png';
//                                                 File pic = File(picPath);
                              
//                                                 if(pic.existsSync()){
//                                                   imageCache.clear();
//                                                   pic.deleteSync(recursive: true);
//                                                 }

//                                                 await _controller.takePicture(picPath);

//                                                 _cameraStateBloc.add(IntUpdateEvent(ProgressCameraDefines.previewState));
//                                               },
//                                             ),
//                                           ),
//                                         if(state == ProgressCameraDefines.readyState)
//                                           Positioned(
//                                             left: 5,
//                                             bottom: 13,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 FontAwesomeIcons.sync,
//                                                 color: FoodFrenzyColors.tertiary,
//                                                 size: 34,
//                                               ), 
//                                               onPressed: () {
//                                                 _swapCameras();
//                                               },
//                                             ),
//                                           ),
//                                         if(state == ProgressCameraDefines.previewState)
//                                           Positioned(
//                                             left: (frame.maxWidth / 2) - (34/2),
//                                             bottom: 13,
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 FontAwesomeIcons.trash,
//                                                 color: FoodFrenzyColors.tertiary,
//                                                 size: 34,
//                                               ), 
//                                               onPressed: (){
//                                                 _cameraStateBloc.add(IntUpdateEvent(ProgressCameraDefines.readyState));
//                                               },
//                                             ),
//                                           ),
//                                         if(state == ProgressCameraDefines.savingState)
//                                           Positioned(
//                                             left: 0,
//                                             bottom: 0,
//                                             child: Container(
//                                               width: frame.maxWidth,
//                                               height: 21,
//                                               child: FirebaseUploader(
//                                                 file: File('$_tempPath/FF_${TextHelpers.getTodaysFirebaseDate()}.png'),
//                                                 onDone: (path) {
//                                                   UserState.firebase.getDocument().then((state){
//                                                     state.updateLastPhotoDate();
//                                                   });
//                                                   UserLog.getTodaysLog().then((log) async{
//                                                     if(log.photoURL == null){
//                                                       await UserPoints.updatePhotoURL(path);
//                                                       await UserLog.updateTodaysPhotoURL(path).then((_) async{
//                                                         //Update points only after log
//                                                         await UserPoints.handlePoints(log, UserPoints.lpIndex);
//                                                       });
//                                                     }
//                                                   });
//                                                   widget.onExit();
//                                                 }
//                                               ),
//                                             ),
//                                           ),
//                                         // if(state == ProgressCameraDefines.readyState) Cover(color: FoodFrenzyColors.jjBlack),
//                                       ],
//                                     );
//                                   }
//                                 );
//                               }
//                             ),
//                           ),
//                         ),
//                       ), 
//                     ),
//                   )
//                 ),
//               );
//             }
//           );
//         }
//       );
//     }, onLoading: (){
//       return CommonAssets.buildLoader();
//     },);
//   }

//   @override
//   Widget build(BuildContext context) {

//     return GestureDetector(
//       onHorizontalDragStart: (_){},
//       child: Container(
//         color: FoodFrenzyColors.jjTransparent,
//         child: CustomActionPopupWhole(
//           visable: widget.visable,
//           middleWidth: widget.middleWidth,
//           buttonWidth: widget.buttonWidth,
//           topButtonBar: _buildLogPPTopButtonBar(),
//           mainWidget: _buildPPPage(),
//           bottomButtonTitle: "Log",
//           bottomButtonIcon: FontAwesomeIcons.save,
//           onAction: (){
//             if(_cameraStateBloc.state == ProgressCameraDefines.previewState){
//               _cameraStateBloc.add(IntUpdateEvent(ProgressCameraDefines.savingState));
//             } else if(_cameraStateBloc.state == ProgressCameraDefines.readyState){
//               widget.onExit();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }