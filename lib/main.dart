import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasource/api_datasource.dart';
import 'data/datasource/onnx_datasource.dart';
import 'data/repositories/prediction_repository_impl.dart';
import 'domain/use_case/predict_disease_usecase.dart';
import 'presentation/viewmodels/prediction_viewmodel.dart';
import 'presentation/viewmodels/settings_viewmodel.dart';
import 'presentation/viewmodels/gemini_viewmodel.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/temas/tema_general.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Settings ViewModel
        ChangeNotifierProvider(
          create: (_) => SettingsViewModel(),
        ),
        
        // Prediction ViewModel con dependencias
        ChangeNotifierProxyProvider<SettingsViewModel, PredictionViewModel>(
          create: (context) {
            final settingsViewModel = Provider.of<SettingsViewModel>(context, listen: false);
            final dataSource = _getDataSource(settingsViewModel);
            final repository = PredictionRepositoryImpl(dataSource);
            final useCase = PredictDiseaseUseCase(repository);
            return PredictionViewModel(useCase);
          },
          update: (context, settingsViewModel, previousViewModel) {
            // Recrear ViewModel cuando cambie el modo de predicción
            final dataSource = _getDataSource(settingsViewModel);
            final repository = PredictionRepositoryImpl(dataSource);
            final useCase = PredictDiseaseUseCase(repository);
            return PredictionViewModel(useCase);
          },
        ),
        
        // Gemini ViewModel para tratamientos y chatbot
        ChangeNotifierProvider(
          create: (_) => GeminiViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SymptoLeaf',
        theme: TemaGeneral.lightTheme,
        initialRoute: AppRoutes.welcome,
        routes: AppRoutes.routes,
      ),
    );
  }

  static dynamic _getDataSource(SettingsViewModel settings) {
    if (settings.mode == PredictionMode.server) {
      return ApiDataSource(settings.serverUrl);
    } else {
      return OnnxDataSource();
    }
  }
}
