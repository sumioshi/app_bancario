// lib/providers/transaction_provider.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/api_service.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  final ApiService _apiService = ApiServiceImpl();

  List<Transaction> get transactions => _transactions;

  // Carrega as transações da API
  Future<void> fetchTransactions() async {
    _transactions = await _apiService.getTransactions();
    notifyListeners();
  }

  // Adiciona uma nova transação
  Future<void> addTransaction(Transaction transaction) async {
    await _apiService.addTransaction(transaction);
    fetchTransactions();
  }

  // Atualiza uma transação existente
  Future<void> updateTransaction(Transaction transaction) async {
    await _apiService.updateTransaction(transaction);
    fetchTransactions();
  }

  // Remove uma transação
  Future<void> deleteTransaction(int id) async {
    await _apiService.deleteTransaction(id);
    fetchTransactions();
  }
}
