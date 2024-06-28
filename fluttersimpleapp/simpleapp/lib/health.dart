import 'package:flutter/material.dart';
import 'healthkit_service.dart';

class HealthDataPage extends StatefulWidget {
  @override
  _HealthDataPageState createState() => _HealthDataPageState();
}

class _HealthDataPageState extends State<HealthDataPage> {
  final HealthKitService _healthKitService = HealthKitService();
  int? _steps;

  @override
  void initState() {
    super.initState();
    _fetchHealthData();
  }

  Future<void> _fetchHealthData() async {
    bool authorized = await _healthKitService.requestAuthorization();
    if (authorized) {
      int? steps = await _healthKitService.fetchSteps();
      setState(() {
        _steps = steps;
      });
    } else {
      // Handle the case when the user does not authorize
      print('Authorization not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Data'),
      ),
      body: Center(
        child: _steps == null
            ? CircularProgressIndicator()
            : Text('Steps: $_steps'),
      ),
    );
  }
}
