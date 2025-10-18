import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/survey_point.dart';

class DataStorageService {
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/schoolyard_map_data.json');
  }

  Future<List<SurveyPoint>> loadData() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final raw = jsonDecode(content) as List<dynamic>;
      return raw.map((e) => SurveyPoint.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveData(List<SurveyPoint> points) async {
    final file = await _getFile();
    final encoded = jsonEncode(points.map((e) => e.toJson()).toList());
    await file.writeAsString(encoded);
  }

  Future<void> appendData(SurveyPoint point) async {
    final list = await loadData();
    list.add(point);
    await saveData(list);
  }

  Future<void> clearData() async {
    final file = await _getFile();
    if (await file.exists()) {
      await file.writeAsString('[]');
    }
  }
}
