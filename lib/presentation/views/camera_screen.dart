import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../viewmodels/prediction_viewmodel.dart';
import '../temas/esquema_color.dart';
import '../temas/tipografia.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _fotos = [];

  Future<void> _tomarFoto() async {
    final XFile? foto = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (foto != null) {
      setState(() {
        _fotos.add(foto);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto capturada correctamente'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _seleccionarGaleria() async {
    final XFile? foto = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (foto != null) {
      setState(() {
        _fotos.add(foto);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Imagen seleccionada de la galería'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _analizarFoto(XFile foto) {
    final predictionViewModel = Provider.of<PredictionViewModel>(context, listen: false);
    predictionViewModel.predictDisease(foto.path);
    Navigator.of(context).pushNamed('/result');
  }

  void _eliminarFoto(int index) {
    setState(() {
      _fotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Fotografías'),
      ),
      body: _fotos.isEmpty
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
              itemCount: _fotos.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final foto = _fotos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.file(
                          File(foto.path),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foto ${index + 1}',
                              style: Tipografia.titulo3,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Capturada el ${DateTime.now().toString().split('.')[0]}',
                              style: Tipografia.caption.copyWith(
                                color: EsquemaColor.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () => _eliminarFoto(index),
                                  icon: const Icon(Icons.delete, size: 20),
                                  label: const Text('Eliminar'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: EsquemaColor.diseaseRed,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: () => _analizarFoto(foto),
                                  icon: const Icon(Icons.search, size: 20),
                                  label: const Text('Analizar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: EsquemaColor.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      // FloatingActionButtons en la parte inferior derecha
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'gallery',
            onPressed: _seleccionarGaleria,
            backgroundColor: EsquemaColor.lightGreen,
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: _tomarFoto,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
