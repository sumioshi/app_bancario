// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

abstract class ApiService {
  Future<List<Transaction>> getTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
}

class ApiServiceImpl extends ApiService {
  static const String apiUrl = "http://localhost:3000/transactions";  // Substitua pela sua URL correta

  @override
  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      return data.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar transações');
    }
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(transaction.toJson()),  // toJson agora funciona corretamente
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar transação');
    }
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${transaction.id}'),  // id agora está correto
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(transaction.toJson()),  // toJson agora funciona corretamente
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar transação');
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao remover transação');
    }
  }
}
