import 'package:flutter/material.dart';
import '../temas/esquema_color.dart';
import '../temas/tipografia.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onTabChange;
  
  const HomeScreen({Key? key, this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: EsquemaColor.backgroundGradient,
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Ícono principal
                Container(
                  width: 120,
                  height: 120,
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
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icon/img.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Título
                Text(
                  'Bienvenido a SymptoLeaf',
                  style: Tipografia.titulo2.copyWith(
                    color: EsquemaColor.darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                
                // Subtítulo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Detecta enfermedades en tus plantas de manera rápida y precisa',
                    style: Tipografia.cuerpo.copyWith(
                      color: EsquemaColor.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Tarjetas de acciones rápidas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildQuickActionCard(
                        context,
                        icon: Icons.camera_alt,
                        title: 'Analizar Planta',
                        subtitle: 'Toma una foto o selecciona de galería',
                        onTap: () {
                          // Cambiar al tab de Fotos (índice 1)
                          if (onTabChange != null) {
                            onTabChange!(1);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildQuickActionCard(
                        context,
                        icon: Icons.chat_bubble_outline,
                        title: 'Asistente Virtual',
                        subtitle: 'Pregunta sobre cuidados y tratamientos',
                        onTap: () => Navigator.pushNamed(context, '/chat'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: EsquemaColor.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: EsquemaColor.primaryGreen,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Tipografia.titulo3.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Tipografia.caption.copyWith(
                        color: EsquemaColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: EsquemaColor.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
