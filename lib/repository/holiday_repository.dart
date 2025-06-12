import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primeiroapp/utils/constants.dart';
import '../models/holiday_model.dart';

class HolidayRepository {
  Future<List<HolidayModel>> getAll() async {
    final response = await http.get(Uri.parse('$URL_BRASILAPI/2025'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => HolidayModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar feriados');
    }
  }
}
