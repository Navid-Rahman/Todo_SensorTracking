import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import '/utils/base_page.dart';

class SensorTracker extends StatefulWidget {
  const SensorTracker({super.key});

  static const String routeName = 'sensor_tracker';

  @override
  State<SensorTracker> createState() => _SensorTrackerState();
}

class _SensorTrackerState extends State<SensorTracker> {
  List<double> gyroXData = [];
  List<double> gyroYData = [];
  List<double> gyroZData = [];

  List<double> accelXData = [];
  List<double> accelYData = [];
  List<double> accelZData = [];

  bool isAlertActive = false;
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;
  StreamSubscription<AccelerometerEvent>? _accelSubscription;

  @override
  void initState() {
    super.initState();
    _startSensorStreaming();
  }

  @override
  void dispose() {
    _stopSensorStreaming();
    super.dispose();
  }

  void _startSensorStreaming() {
    _gyroSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        // print('Gyroscope: x=${event.x}, y=${event.y}, z=${event.z}');
        gyroXData.add(event.x);
        gyroYData.add(event.y);
        gyroZData.add(event.z);
        _checkAlertCondition();
      });
    });

    _accelSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        // print('Accelerometer: x=${event.x}, y=${event.y}, z=${event.z}');
        accelXData.add(event.x);
        accelYData.add(event.y);
        accelZData.add(event.z);
        _checkAlertCondition();
      });
    });
  }

  void _stopSensorStreaming() {
    _gyroSubscription?.cancel();
    _accelSubscription?.cancel();
  }

  void _checkAlertCondition() {
    if (isAlertActive) {
      return;
    }

    if ((gyroXData.isNotEmpty &&
            gyroYData.isNotEmpty &&
            gyroXData.last.abs() > 5 &&
            gyroYData.last.abs() > 5) ||
        (accelXData.isNotEmpty &&
            accelYData.isNotEmpty &&
            accelXData.last.abs() > 10 &&
            accelYData.last.abs() > 10)) {
      setState(() {
        isAlertActive = true;
      });
      _showAlert();
    }
  }

  void _showAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'ALERT: High movement detected!',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
    // Reset the alert after some time
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isAlertActive = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      showBackButton: true,
      appBarTitle: 'Sensor Tracker',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildGraph(
                'Gyroscope Sensor Data', gyroXData, gyroYData, gyroZData),
            const SizedBox(height: 20),
            _buildGraph('Accelerometer Sensor Data', accelXData, accelYData,
                accelZData),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph(String title, List<double> xData, List<double> yData,
      List<double> zData) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEAEAEA)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const Divider(
              color: Color(0xffEAEAEA),
              thickness: 1,
            ),
            SfCartesianChart(
              primaryXAxis: const NumericAxis(),
              primaryYAxis: const NumericAxis(),
              series: <LineSeries>[
                LineSeries<double, int>(
                  dataSource: xData,
                  xValueMapper: (double value, int index) => index,
                  yValueMapper: (double value, int index) => value,
                  name: 'X Axis',
                  color: const Color(0xffe80606),
                ),
                LineSeries<double, int>(
                  dataSource: yData,
                  xValueMapper: (double value, int index) => index,
                  yValueMapper: (double value, int index) => value,
                  name: 'Y Axis',
                  color: const Color(0xff117128),
                ),
                LineSeries<double, int>(
                  dataSource: zData,
                  xValueMapper: (double value, int index) => index,
                  yValueMapper: (double value, int index) => value,
                  name: 'Z Axis',
                  color: const Color(0xff0c329a),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
