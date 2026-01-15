import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/foto_controller.dart';
import '../providers/foto_provider.dart';
import '../widgets/foto_item.dart';
import '../viewmodels/prediction_viewmodel.dart';
import '../temas/esquema_color.dart';
import '../temas/tipografia.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FotoProvider>(context);
    final controller = FotoController(provider);

    return Scaffold(
      body: provider.fotos.isEmpty
          ? Container(
              decoration: const BoxDecoration(
                gradient: EsquemaColor.backgroundGradient,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: EsquemaColor.primaryGreen.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 60,
                        color: EsquemaColor.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'No hay fotos capturadas',
                      style: Tipografia.titulo3.copyWith(
                        color: EsquemaColor.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Presiona el botón de cámara para capturar',
                      style: Tipografia.cuerpo.copyWith(
                        color: EsquemaColor.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: provider.fotos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final foto = provider.fotos[index];
                return FotoItem(
                  foto: foto,
                  onAnalizar: () {
                    final predictionViewModel = Provider.of<PredictionViewModel>(context, listen: false);
                    predictionViewModel.predictDisease(foto.path);
                    Navigator.of(context).pushNamed('/result');
                  },
                  onEliminar: () => provider.eliminarFoto(index),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'gallery',
            onPressed: () => controller.seleccionarGaleria(context),
            backgroundColor: EsquemaColor.lightGreen,
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () => controller.tomarFoto(context),
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
