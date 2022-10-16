// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// class Connection extends ChangeNotifier{
//  bool? isConnected =false;
//
//   Future<void> execute(
//       InternetConnectionChecker internetConnectionChecker,
//       ) async {
//     // Simple check to see if we have Internet
//     isConnected = await InternetConnectionChecker().hasConnection;
//     notifyListeners();
//     final StreamSubscription<InternetConnectionStatus> listener =
//     InternetConnectionChecker().onStatusChange.listen(
//           (InternetConnectionStatus status) {
//         switch (status) {
//           case InternetConnectionStatus.connected:
//             isConnected= true;
//             notifyListeners();
//           // ignore: avoid_print
//             print('Data connection is available.');
//             break;
//           case InternetConnectionStatus.disconnected:
//           // ignore: avoid_print
//             isConnected= false;
//             notifyListeners();
//
//             print('You are disconnected from the internet.');
//             break;
//         }
//       },
//     );
//
//     // close listener after 30 seconds, so the program doesn't run forever
//     await Future<void>.delayed(const Duration(seconds: 30));
//     await listener.cancel();
//     notifyListeners();
//   }
// }