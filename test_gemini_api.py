"""
Test script para verificar que la API Key de Gemini funciona correctamente.
Ejecutar con: python test_gemini_api.py
"""

import requests
import os

def test_gemini_api():
    # Leer API Key desde el archivo oculto
    key_file = os.path.join(os.path.dirname(__file__), 'lib', '.keyapigemeni')
    
    try:
        with open(key_file, 'r') as f:
            api_key = f.read().strip()
        print(f"✅ API Key cargada: {api_key[:10]}...{api_key[-4:]}")
    except FileNotFoundError:
        print("❌ Error: No se encontró el archivo lib/.keyapigemeni")
        return False
    
    # Hacer request a la API
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={api_key}"
    
    payload = {
        "contents": [{
            "parts": [{
                "text": "Responde solo con: 'Hola, la API funciona correctamente! 🎉'"
            }]
        }]
    }
    
    print("\n🔄 Enviando request a Gemini API...")
    
    try:
        response = requests.post(url, json=payload, timeout=30)
        data = response.json()
        
        if response.status_code == 200:
            # Extraer texto de respuesta
            text = data.get('candidates', [{}])[0].get('content', {}).get('parts', [{}])[0].get('text', '')
            print(f"\n✅ ÉXITO! Respuesta de Gemini:")
            print(f"   {text}")
            return True
        else:
            # Error de API
            error = data.get('error', {})
            error_code = error.get('code', response.status_code)
            error_message = error.get('message', 'Error desconocido')
            
            print(f"\n❌ Error {error_code}:")
            print(f"   {error_message}")
            
            # Verificar si es error de quota
            if 'quota' in error_message.lower() or error_code == 429:
                print("\n⚠️  NOTA: Has excedido el límite de requests por minuto.")
                print("   Espera 1 minuto e intenta de nuevo.")
            
            return False
            
    except requests.exceptions.Timeout:
        print("❌ Error: Timeout - La API tardó demasiado en responder")
        return False
    except requests.exceptions.ConnectionError:
        print("❌ Error: No hay conexión a internet")
        return False
    except Exception as e:
        print(f"❌ Error inesperado: {e}")
        return False


def test_treatment_prompt():
    """Prueba un prompt de tratamiento como lo haría la app"""
    key_file = os.path.join(os.path.dirname(__file__), 'lib', '.keyapigemeni')
    
    with open(key_file, 'r') as f:
        api_key = f.read().strip()
    
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={api_key}"
    
    prompt = """
Soy un agricultor y necesito ayuda urgente.

Mi planta de **Tomate** tiene **Virus del mosaico**.

Por favor proporciona en máximo 100 palabras:
1. 🔍 Un síntoma principal
2. 💊 Un tratamiento orgánico
3. 🛡️ Un tip de prevención
"""
    
    payload = {
        "contents": [{
            "parts": [{"text": prompt}]
        }]
    }
    
    print("\n" + "="*50)
    print("🌱 PRUEBA DE TRATAMIENTO")
    print("="*50)
    print("Consultando tratamiento para: Tomate - Virus del mosaico")
    
    try:
        response = requests.post(url, json=payload, timeout=30)
        data = response.json()
        
        if response.status_code == 200:
            text = data.get('candidates', [{}])[0].get('content', {}).get('parts', [{}])[0].get('text', '')
            print(f"\n✅ Respuesta de Gemini:\n")
            print(text)
            return True
        else:
            error = data.get('error', {}).get('message', 'Error')
            print(f"❌ Error: {error}")
            return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False


if __name__ == "__main__":
    print("="*50)
    print("🧪 TEST DE API GEMINI PARA SYMPTOLEAF")
    print("="*50)
    
    # Test básico
    if test_gemini_api():
        # Si funciona, probar prompt de tratamiento
        test_treatment_prompt()
    
    print("\n" + "="*50)
    print("Prueba completada")
    print("="*50)
