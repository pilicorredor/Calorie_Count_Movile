import 'package:calorie_counter/providers/permissions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {
    final permissions = ref.watch(permissionsProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.CameraGranted,
          title: const Text('Cámara'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.PhotoLibraryGranted,
          title: const Text('Galería de fotos'),
          subtitle: Text('${permissions.photoLibrary}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.CameraGranted,
          title: const Text('Location'),
          subtitle: Text('${permissions.location}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.CameraGranted,
          title: const Text('Sensors'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
      ],
    );
  }
}
