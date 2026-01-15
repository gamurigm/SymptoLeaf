import 'dart:io';
import 'package:flutter/material.dart';
import '../models/foto.dart';
import '../temas/esquema_color.dart';
import '../temas/tipografia.dart';

class FotoItem extends StatelessWidget {
  final Foto foto;
  final VoidCallback onAnalizar;
  final VoidCallback onEliminar;

  const FotoItem({
    Key? key,
    required this.foto,
    required this.onAnalizar,
    required this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  foto.nombre,
                  style: Tipografia.titulo3,
                ),
                const SizedBox(height: 4),
                Text(
                  foto.description,
                  style: Tipografia.caption.copyWith(
                    color: EsquemaColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: onEliminar,
                      icon: const Icon(Icons.delete, size: 20),
                      label: const Text('Eliminar'),
                      style: TextButton.styleFrom(
                        foregroundColor: EsquemaColor.diseaseRed,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: onAnalizar,
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
  }
}
