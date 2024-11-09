import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      //Permission.photos.status,
      Permission.storage.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);
    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  openSettingsScreen() {
    openAppSettings();
  }

  void _checkPermissionState(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionState(status);
  }

 /* requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    _checkPermissionState(status);
  }
  */
  requestPhotoLibraryAccess() async {
    final status = await Permission.storage.request(); // Cambiado a storage
    state = state.copyWith(photoLibrary: status);

    _checkPermissionState(status);
  }
  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionState(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionState(status);
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get CameraGranted {
    return camera == PermissionStatus.granted;
  }

  get PhotoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }

  get SensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get LocationGranted {
    return location == PermissionStatus.granted;
  }

  get LocationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  // ignore: non_constant_identifier_names
  get LocationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) =>
      PermissionsState(
        camera: camera ?? this.camera,
        photoLibrary: photoLibrary ?? this.photoLibrary,
        sensors: sensors ?? this.sensors,
        location: location ?? this.location,
        locationAlways: locationAlways ?? this.locationAlways,
        locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
      );
}
