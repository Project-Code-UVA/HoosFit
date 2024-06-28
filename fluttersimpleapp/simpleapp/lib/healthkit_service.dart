import 'package:health/health.dart';

class HealthKitService {
  final HealthFactory _health = HealthFactory();
  
  Future<bool> requestAuthorization() async {
    final types = [
      HealthDataType.STEPS,
    ];
   
    return await _health.requestAuthorization(types);
  }

  Future<int?> fetchSteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final types = [
      HealthDataType.STEPS,
    ];

    List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(midnight, now, types);
    int steps = healthData.fold(0, (sum, point) => sum + (point.value is double ? (point.value as double).toInt() : point.value as int));


    return steps;
  }
}
