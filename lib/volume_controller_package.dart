import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';



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
//       // Handle error if volume controller fails
//       print('Error fetching volume status: $e');
//     }
//   }

//   Future<void> _toggleMute() async {
//     try {
//       if (isMuted) {
//         // If muted, unmute by setting volume to 1 (100%)
//         await FlutterVolumeController.setVolume(1);
//       } else {
//         // If not muted, mute by setting volume to 0
//         await FlutterVolumeController.setVolume(0);
//       }

//       // Update the state after the volume is changed
//       await Future.delayed(const Duration(milliseconds: 500));
//       await _checkMuteStatus();
//     } catch (e) {
//       // Handle error if setting volume fails
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
