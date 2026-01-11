import 'package:flutter/material.dart';
import '../../domain/entities/prediction_entity.dart';
import '../../domain/use_case/predict_disease_usecase.dart';

enum PredictionState { initial, loading, success, error }

class PredictionViewModel extends ChangeNotifier {
  final PredictDiseaseUseCase useCase;

  PredictionViewModel(this.useCase);

  PredictionState _state = PredictionState.initial;
  PredictionEntity? _prediction;
  String _errorMessage = '';

  PredictionState get state => _state;
  PredictionEntity? get prediction => _prediction;
  String get errorMessage => _errorMessage;

  Future<void> predictDisease(String imagePath) async {
    _state = PredictionState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _prediction = await useCase.execute(imagePath);
      _state = PredictionState.success;
    } catch (e) {
      _state = PredictionState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void reset() {
    _state = PredictionState.initial;
    _prediction = null;
    _errorMessage = '';
    notifyListeners();
  }
}
