import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/survey_point.dart';
import '../services/data_storage_service.dart';

class DataMapScreen extends StatefulWidget {
  const DataMapScreen({super.key});

  @override
  State<DataMapScreen> createState() => _DataMapScreenState();
}

class _DataMapScreenState extends State<DataMapScreen> {
  final DataStorageService _storage = DataStorageService();
  List<SurveyPoint> _points = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data = await _storage.loadData();
    setState(() {
      _points = data.reversed.toList(); // newest first
      _loading = false;
    });
  }

  Color _colorForLight(double value) {
    final v = (value / 1000).clamp(0.0, 1.0);
    return Color.lerp(Colors.yellow.shade100, Colors.amber.shade700, v)!;
  }

  Color _colorForDynamic(double value) {
    final v = (value / 20).clamp(0.0, 1.0);
    return Color.lerp(Colors.orange.shade100, Colors.red.shade700, v)!;
  }

  Color _colorForMagnetic(double value) {
    final v = (value / 200).clamp(0.0, 1.0);
    return Color.lerp(Colors.blue.shade100, Colors.blue.shade800, v)!;
  }

  Widget _overviewCard() {
    if (_points.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: const Text('Chưa có dữ liệu nào.'),
        ),
      );
    }

    // compute summary
    double maxLight = -double.infinity;
    double minLight = double.infinity;
    double maxDynamic = -double.infinity;

    for (final p in _points) {
      if (p.sensor.light > maxLight) maxLight = p.sensor.light;
      if (p.sensor.light < minLight) minLight = p.sensor.light;
      if (p.sensor.dynamicLevel > maxDynamic) maxDynamic = p.sensor.dynamicLevel;
    }

    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tổng quan Dữ liệu', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Tổng số điểm khảo sát: ${_points.length}'),
            Text('Điểm sáng nhất: ${maxLight.isFinite ? maxLight.toStringAsFixed(1) : 'N/A'} lux'),
            Text('Điểm tối nhất: ${minLight.isFinite ? minLight.toStringAsFixed(1) : 'N/A'} lux'),
            Text('Điểm năng động nhất: ${maxDynamic.isFinite ? maxDynamic.toStringAsFixed(2) : 'N/A'}'),
          ],
        ),
      ),
    );
  }

  Widget _pointCard(SurveyPoint p, int index) {
    final nf = NumberFormat('#.####');
    final dtf = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Điểm ${_points.length - index}  •  (${nf.format(p.latitude)}, ${nf.format(p.longitude)})',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(dtf.format(p.timestamp), style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _smallMetric(Icons.wb_sunny, '${p.sensor.light.toStringAsFixed(1)} lux', _colorForLight(p.sensor.light)),
                _smallMetric(Icons.directions_walk, p.sensor.dynamicLevel.toStringAsFixed(2), _colorForDynamic(p.sensor.dynamicLevel)),
                _smallMetric(Icons.magnet_on, '${p.sensor.magnetic.toStringAsFixed(1)} µT', _colorForMagnetic(p.sensor.magnetic)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallMetric(IconData icon, String text, Color bg) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: bg, child: Icon(icon, color: Colors.white)),
        const SizedBox(height: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ Dữ liệu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('Xác nhận'),
                  content: const Text('Xóa toàn bộ dữ liệu?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Hủy')),
                    TextButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Xóa')),
                  ],
                ),
              );
              if (confirm ?? false) {
                await _storage.clearData();
                await _load();
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              _overviewCard(),
              const SizedBox(height: 10),
              ...List.generate(_points.length, (i) => _pointCard(_points[i], i)),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _load,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
