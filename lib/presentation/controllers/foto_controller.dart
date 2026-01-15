import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/foto_provider.dart';
import '../models/foto.dart';

class FotoController {
  final FotoProvider fotoProvider;
  final ImagePicker picker = ImagePicker();

  FotoController(this.fotoProvider);

  // Método para tomar foto desde cámara
  Future<void> tomarFoto(BuildContext context) async {
    final XFile? foto = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (foto != null) {
      final nueva = Foto(
        path: foto.path,
        nombre: "Foto ${fotoProvider.fotos.length + 1}",
        description: 'Foto tomada el ${DateTime.now()}',
      );

      // Agregar la foto al proveedor
      fotoProvider.agregarFoto(nueva);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Foto guardada de forma correcta...!"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Método para seleccionar desde galería
  Future<void> seleccionarGaleria(BuildContext context) async {
    final XFile? foto = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (foto != null) {
      final nueva = Foto(
        path: foto.path,
        nombre: "Foto ${fotoProvider.fotos.length + 1}",
        description: 'Seleccionada de galería el ${DateTime.now()}',
      );

      // Agregar la foto al proveedor
      fotoProvider.agregarFoto(nueva);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Imagen seleccionada de la galería"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
