// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sound_mode/permission_handler.dart';
// import 'package:sound_mode/sound_mode.dart';
// import 'package:sound_mode/utils/ringer_mode_statuses.dart';

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   RingerModeStatus _soundMode = RingerModeStatus.unknown;
//   String _permissionStatus = "Checking permissions...";
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentSoundMode();
//     _getPermissionStatus();
//   }

//   Future<void> _getCurrentSoundMode() async {
//     setState(() {
//       _loading = true;
//     });

//     try {
//       final ringerStatus = await SoundMode.ringerModeStatus;
//       setState(() {
//         _soundMode = ringerStatus;
//       });
//     } catch (err) {
//       setState(() {
//         _soundMode = RingerModeStatus.unknown;
//       });
//       print('Error fetching sound mode: $err');
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   Future<void> _getPermissionStatus() async {
//     try {
//       final permissionStatus = await PermissionHandler.permissionsGranted;
//       setState(() {
//         _permissionStatus = permissionStatus != null
//             ? (permissionStatus
//                 ? "Permissions Enabled"
//                 : "Permissions not granted")
//             : "Unknown permission status";
//       });
//     } catch (err) {
//       setState(() {
//         _permissionStatus = "Error fetching permission status";
//       });
//       print('Error fetching permission status: $err');
//     }
//   }

//   Future<void> _setSoundMode(RingerModeStatus mode) async {
//     setState(() {
//       _loading = true;
//     });

//     try {
//       final status = await SoundMode.setSoundMode(mode);
//       setState(() {
//         _soundMode = status;
//       });
//     } on PlatformException {
//       print('Do Not Disturb access permissions required!');
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   Future<void> _openDoNotDisturbSettings() async {
//     await PermissionHandler.openDoNotDisturbSetting();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Sound Mode App'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               if (_loading) CircularProgressIndicator(),
//               Text('Current Sound Mode: ${_soundMode.toString()}'),
//               Text('Permission status: $_permissionStatus'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _getCurrentSoundMode,
//                 child: Text('Get Current Sound Mode'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _setSoundMode(RingerModeStatus.normal),
//                 child: Text('Set Normal Mode'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _setSoundMode(RingerModeStatus.silent),
//                 child: Text('Set Silent Mode'),
//               ),
//               ElevatedButton(
//                 onPressed: () => _setSoundMode(RingerModeStatus.vibrate),
//                 child: Text('Set Vibrate Mode'),
//               ),
//               ElevatedButton(
//                 onPressed: _openDoNotDisturbSettings,
//                 child: Text('Open Do Not Disturb Settings'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
