import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:wear_os_flutter/core/time/timezone.dart';
import 'core/wear/src/ambient_widget.dart';
import 'core/wear/src/shape_widget.dart';

void main() {
  tzdata.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter WearOS',
      home: WatchScreen(),
    );
  }
}

class WatchScreen extends StatefulWidget {
  const WatchScreen({
    super.key,
  });

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  Timer? timer;
  String clock = '00:00';
  String? location;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          clock = getLocalTimeZone(
            timeZone: IndonesiaTimeZone.values.byName(
              DateTime.now().timeZoneName,
            ),
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          clock = getLocalTimeZone(
            timeZone: IndonesiaTimeZone.values.byName(
              DateTime.now().timeZoneName,
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WatchShape(
          builder: (BuildContext context, WearShape shape, Widget? widget) {
        return Center(
          child: AmbientMode(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin),
                    Text("Malang, Jawa Timur")
                  ],
                ),
                Text(
                  clock,
                  style: const TextStyle(fontSize: 32),
                ),
                Text(DateTime.now().timeZoneName),
              ],
            ),
            builder: (context, mode, widget) {
              return widget ?? const SizedBox();
            },
          ),
        );
      }),
    );
  }
}
