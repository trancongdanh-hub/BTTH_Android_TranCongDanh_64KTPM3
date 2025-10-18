import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/sensor_data.dart';

class SensorService {
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  final StreamController<SensorData> _sensorDataController = StreamController<SensorData>.broadcast();

  Stream<SensorData> get sensorDataStream => _sensorDataController.stream;

  bool _isListening = false;
  AccelerometerEvent? _lastAccelerometerEvent;
  MagnetometerEvent? _lastMagnetometerEvent;

  void startListening() {
    if (_isListening) return;

    _isListening = true;

    // Listen to accelerometer for activity level
    _accelerometerSubscription = accelerometerEventStream().listen((AccelerometerEvent event) {
      _lastAccelerometerEvent = event;
      _updateSensorData();
    });

    // Listen to magnetometer for magnetic field
    _magnetometerSubscription = magnetometerEventStream().listen((MagnetometerEvent event) {
      _lastMagnetometerEvent = event;
      _updateSensorData();
    });
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    _isListening = false;
  }

  void _updateSensorData() {
    // This method will be called by the accelerometer listener
    // We'll get the current sensor values and calculate magnitudes
    final sensorData = getCurrentSensorData();
    _sensorDataController.add(sensorData);
  }

  SensorData getCurrentSensorData() {
    // Calculate activity level (magnitude of acceleration)
    double activityLevel = 0.0;
    if (_lastAccelerometerEvent != null) {
      activityLevel = sqrt(
        _lastAccelerometerEvent!.x * _lastAccelerometerEvent!.x +
        _lastAccelerometerEvent!.y * _lastAccelerometerEvent!.y +
        _lastAccelerometerEvent!.z * _lastAccelerometerEvent!.z
      );
    }

    // Calculate magnetic field magnitude
    double magneticField = 0.0;
    if (_lastMagnetometerEvent != null) {
      magneticField = sqrt(
        _lastMagnetometerEvent!.x * _lastMagnetometerEvent!.x +
        _lastMagnetometerEvent!.y * _lastMagnetometerEvent!.y +
        _lastMagnetometerEvent!.z * _lastMagnetometerEvent!.z
      );
    }

    // Simulate light sensor data (since sensors_plus doesn't have light sensor)
    // In a real app, you might need to use platform-specific code for light sensor
    final lightIntensity = _getSimulatedLightIntensity();

    return SensorData(
      lightIntensity: lightIntensity,
      activityLevel: activityLevel,
      magneticField: magneticField,
      timestamp: DateTime.now(),
    );
  }

  // Simulate light sensor reading
  // In a real implementation, you would use platform-specific code
  double _getSimulatedLightIntensity() {
    // Simulate light intensity based on time of day
    final now = DateTime.now();
    final hour = now.hour;

    // Simulate day/night cycle
    if (hour >= 6 && hour <= 18) {
      // Daytime: simulate sunlight intensity
      final baseIntensity = 1000.0;
      final hourFactor = sin((hour - 6) * pi / 12);
      return baseIntensity * (0.3 + 0.7 * hourFactor);
    } else {
      // Nighttime: simulate low light
      return 10.0 + Random().nextDouble() * 50.0;
    }
  }

  void dispose() {
    stopListening();
    _sensorDataController.close();
  }
}
