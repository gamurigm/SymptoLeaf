import 'package:flutter/services.dart';

/// Configuración para la API de Gemini
/// 
/// La API Key se carga desde el archivo oculto .keyapigemeni
/// para evitar subirla accidentalmente al repositorio
class GeminiConfig {
  static String? _apiKey;
  
  // Modelo a usar (gemini-2.0-flash es el modelo rápido actual)
  static const String model = 'gemini-2.0-flash';
  
  /// Carga la API Key desde el archivo oculto
  static Future<String> loadApiKey() async {
    if (_apiKey != null) return _apiKey!;
    
    try {
      _apiKey = await rootBundle.loadString('lib/.keyapigemeni');
      _apiKey = _apiKey!.trim();
      return _apiKey!;
    } catch (e) {
      throw Exception('No se pudo cargar la API Key. Asegúrate de crear el archivo lib/.keyapigemeni');
    }
  }
  
  /// Obtiene la API Key (debe llamarse loadApiKey primero)
  static String get apiKey => _apiKey ?? 'NO_KEY_LOADED';
  
  // Prompt del sistema para el chatbot agrícola
  static const String systemPrompt = '''
Eres un experto agrónomo y fitopatólogo virtual llamado "AgroAsistente". 
Tu especialidad es ayudar a agricultores y jardineros con:
- Diagnóstico y tratamiento de enfermedades en plantas
- Recomendaciones de cuidado y prevención
- Consejos sobre riego, fertilización y poda
- Identificación de plagas y su control

Responde siempre en español, de forma clara y práctica.
Cuando des tratamientos, incluye opciones orgánicas y químicas cuando sea posible.
Sé conciso pero completo. Usa emojis para hacer más amigable la conversación.
''';
}
