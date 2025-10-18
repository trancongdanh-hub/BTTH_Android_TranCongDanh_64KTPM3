import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:schoolyard_heatmap/models/survey_point.dart';
import 'package:schoolyard_heatmap/services/sensor_service.dart';
import 'package:schoolyard_heatmap/services/location_service.dart';
import 'package:schoolyard_heatmap/services/data_storage_service.dart';

class SurveyStationScreen extends StatefulWidget {
  const SurveyStationScreen({super.key});

  @override
  State<SurveyStationScreen> createState() => _SurveyStationScreenState();
}

class _SurveyStationScreenState extends State<SurveyStationScreen> {
  final SensorService _sensorService = SensorService();
  final LocationService _locationService = LocationService();
  final DataStorageService _storage = DataStorageService();

  double _light = 0.0;
  double _dynamic = 0.0;
  double _magnetic = 0.0;
  bool _recording = false;
  int _savedCount = 0;
  bool _gpsOk = false;

  @override
  void initState() {
    super.initState();
    _sensorService.startListening(onData: (l, d, m) {
      setState(() {
        _light = l;
        _dynamic = d;
        _magnetic = m;
      });
    });
    _loadSavedCount();
    _checkGps(); // quick attempt to see if location available
  }

  Future<void> _loadSavedCount() async {
    final data = await _storage.loadData();
    setState(() => _savedCount = data.length);
  }

  Future<void> _checkGps() async {
    final loc = await _locationService.getCurrentLocation();
    setState(() => _gpsOk = loc != null);
  }

  Future<void> _onRecordPressed() async {
    setState(() => _recording = true);
    final loc = await _locationService.getCurrentLocation();
    if (loc == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Không lấy được vị trí. Hãy bật GPS và cấp quyền.')),
      );
      setState(() => _recording = false);
      return;
    }

    final point = SurveyPoint(
      latitude: loc.latitude ?? 0.0,
      longitude: loc.longitude ?? 0.0,
      timestamp: DateTime.now(),
      sensor: SensorData(light: _light, dynamicLevel: _dynamic, magnetic: _magnetic),
    );

    await _storage.appendData(point);
    await _loadSavedCount();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Ghi dữ liệu thành công!')),
    );

    setState(() => _recording = false);
  }

  @override
  void dispose() {
    _sensorService.stop();
    super.dispose();
  }

  Color _colorForLight(double value) {
    // Map 0..1000 -> light to yellow shades
    final v = (value / 1000).clamp(0.0, 1.0);
    return Color.lerp(Colors.grey.shade200, Colors.amber.shade700, v)!;
  }

  Color _colorForDynamic(double value) {
    // map 0..20 -> red intensity
    final v = (value / 20).clamp(0.0, 1.0);
    return Color.lerp(Colors.grey.shade200, Colors.red.shade700, v)!;
  }

  Color _colorForMagnetic(double value) {
    final v = (value / 200).clamp(0.0, 1.0);
    return Color.lerp(Colors.grey.shade200, Colors.blue.shade700, v)!;
  }

  Widget _sensorCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nf = NumberFormat('#,##0.0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trạm Khảo sát'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => Navigator.of(context).pop(), // optional
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // System status card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: const Text('Trạng thái Hệ thống', style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text('Số điểm đã ghi: $_savedCount\nCảm biến: Hoạt động'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _gpsOk ? Colors.green.shade600 : Colors.red.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_gpsOk ? 'GPS OK' : 'GPS OFF', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: Text('Dữ liệu Trực tiếp', style: Theme.of(context).textTheme.subtitle1)),
            const SizedBox(height: 8),

            // Sensor cards
            _sensorCard(
              icon: Icons.wb_sunny,
              title: 'Cường độ Ánh sáng',
              value: '${nf.format(_light)} lux',
              color: _colorForLight(_light),
            ),

            _sensorCard(
              icon: Icons.directions_walk,
              title: 'Độ Năng động',
              value: _dynamic.toStringAsFixed(2),
              color: _colorForDynamic(_dynamic),
            ),

            _sensorCard(
              icon: Icons.magnet_on,
              title: 'Cường độ Từ trường',
              value: '${_magnetic.toStringAsFixed(1)} µT',
              color: _colorForMagnetic(_magnetic),
            ),

            const Spacer(),

            // Record button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(_recording ? 'Đang ghi dữ liệu...' : 'Ghi Dữ liệu tại Điểm này'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _recording ? null : _onRecordPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
