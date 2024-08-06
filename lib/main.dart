import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:soundapp/sound_mode.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mute Toggle App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MuteToggleScreen(),
//     );
//   }
// }

// class MuteToggleScreen extends StatefulWidget {
//   const MuteToggleScreen({Key? key}) : super(key: key);

//   @override
//   _MuteToggleScreenState createState() => _MuteToggleScreenState();
// }

// class _MuteToggleScreenState extends State<MuteToggleScreen> {
//   bool isMuted = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkMuteStatus();
//   }

//   Future<void> _checkMuteStatus() async {
//     try {
//       final volume = await FlutterVolumeController.getVolume();
//       setState(() {
//         isMuted = volume == 0;
//       });
//     } catch (e) {
//       print('Error fetching volume status: $e');
//     }
//   }

//   Future<void> _toggleMute() async {
//     try {
//       if (isMuted) {
//         await FlutterVolumeController.setVolume(1);
//       } else {
//         await FlutterVolumeController.setVolume(0);
//       }

//       await Future.delayed(const Duration(milliseconds: 500));
//       await _checkMuteStatus();
//     } catch (e) {
//       print('Error setting volume: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mute Toggle App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               isMuted ? 'Phone is Muted' : 'Phone is Not Muted',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _toggleMute,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(16.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Icon(
//                     isMuted ? Icons.volume_off : Icons.volume_up,
//                     size: 36.0,
//                   ),
//                   const SizedBox(height: 4.0),
//                   Text(
//                     isMuted ? 'Unmute' : 'Mute',
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MuteVibrateScreen(),
    );
  }
}

class MuteVibrateScreen extends StatefulWidget {
  @override
  _MuteVibrateScreenState createState() => _MuteVibrateScreenState();
}

class _MuteVibrateScreenState extends State<MuteVibrateScreen> {
  static const platform = MethodChannel('com.example.soundapp/sound');

  int _mode = 2;

  void _toggleSoundMode() async {
    switch (_mode) {
      case 0:
        await _setSoundMode('unmute');
        setState(() {
          _mode = 1;
        });
        break;
      case 1:
        await _setSoundMode('vibrate');
        setState(() {
          _mode = 2;
        });
        break;
      case 2:
        await _setSoundMode('mute');
        setState(() {
          _mode = 0;
        });
        break;
    }
  }

  Future<void> _setSoundMode(String mode) async {
    try {
      await platform.invokeMethod('setSoundMode', mode);
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        print("Permission denied: ${e.message}");
      } else {
        print("Failed to set sound mode: '${e.message}'.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mute/Vibrate Toggle'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleSoundMode,
              child: Column(
                children: [
                  Icon(
                    _mode == 0
                        ? Icons.volume_up
                        : _mode == 1
                            ? Icons.vibration
                            : Icons.volume_off,
                    size: 36.0,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    _mode == 0
                        ? 'unmute'
                        : _mode == 1
                            ? 'Vibrate'
                            : 'Mute',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
