import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Logger functionality replaced with print statements

part 'camera_service.g.dart';

/// Available cameras in the system
@Riverpod(keepAlive: true)
Future<List<CameraDescription>> availableCameras(AvailableCamerasRef ref) async {
  try {
    final cameras = await availableCameras();
    print('Found ${cameras.length} cameras');
    return cameras;
  } catch (e) {
    print('Error getting available cameras: $e');
    return [];
  }
}

/// Camera service for managing camera functionality
@Riverpod(keepAlive: true)
class CameraService extends _$CameraService {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  
  @override
  Future<CameraState> build() async {
    _cameras = await _initializeCameras();
    return CameraState(
      cameras: _cameras,
      isInitialized: _cameras.isNotEmpty,
    );
  }
  
  /// Initialize available cameras
  Future<List<CameraDescription>> _initializeCameras() async {
    try {
      final cameras = await availableCameras();
      print('Initialized ${cameras.length} cameras');
      
      for (int i = 0; i < cameras.length; i++) {
        final camera = cameras[i];
        print('Camera $i: ${camera.name} - ${camera.lensDirection}');
      }
      
      return cameras;
    } catch (e) {
      print('Error initializing cameras: $e');
      return [];
    }
  }
  
  /// Get camera by lens direction
  CameraDescription? getCameraByDirection(CameraLensDirection direction) {
    try {
      return _cameras.firstWhere(
        (camera) => camera.lensDirection == direction,
      );
    } catch (e) {
      print('No camera found with direction: $direction');
      return null;
    }
  }
  
  /// Get front camera
  CameraDescription? get frontCamera => getCameraByDirection(CameraLensDirection.front);
  
  /// Get back camera
  CameraDescription? get backCamera => getCameraByDirection(CameraLensDirection.back);
  
  /// Initialize camera controller
  Future<CameraController?> initializeController(
    CameraDescription camera, {
    ResolutionPreset resolution = ResolutionPreset.high,
    bool enableAudio = false,
  }) async {
    try {
      // Dispose existing controller
      await _controller?.dispose();
      
      // Create new controller
      _controller = CameraController(
        camera,
        resolution,
        enableAudio: enableAudio,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      
      // Initialize controller
      await _controller!.initialize();
      
      print('Camera controller initialized: ${camera.name}');
      
      // Update state
      state = AsyncData(
        state.value!.copyWith(
          currentController: _controller,
          currentCamera: camera,
        ),
      );
      
      return _controller;
    } catch (e) {
      print('Error initializing camera controller: $e');
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }
  
  /// Take a picture
  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print('Camera controller not initialized');
      return null;
    }
    
    try {
      // Ensure flash is off for better results
      await _controller!.setFlashMode(FlashMode.off);
      
      // Take the picture
      final image = await _controller!.takePicture();
      print('Picture taken: ${image.path}');
      
      return image;
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }
  
  /// Start video recording
  Future<void> startVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print('Camera controller not initialized');
      return;
    }
    
    if (_controller!.value.isRecordingVideo) {
      print('Already recording video');
      return;
    }
    
    try {
      await _controller!.startVideoRecording();
      print('Video recording started');
      
      // Update state
      state = AsyncData(
        state.value!.copyWith(isRecording: true),
      );
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }
  
  /// Stop video recording
  Future<XFile?> stopVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      print('Camera controller not initialized');
      return null;
    }
    
    if (!_controller!.value.isRecordingVideo) {
      print('Not recording video');
      return null;
    }
    
    try {
      final video = await _controller!.stopVideoRecording();
      print('Video recording stopped: ${video.path}');
      
      // Update state
      state = AsyncData(
        state.value!.copyWith(isRecording: false),
      );
      
      return video;
    } catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }
  
  /// Switch between front and back camera
  Future<void> switchCamera() async {
    final currentDirection = state.value?.currentCamera?.lensDirection;
    
    if (currentDirection == null) {
      print('No current camera to switch from');
      return;
    }
    
    final newDirection = currentDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    
    final newCamera = getCameraByDirection(newDirection);
    
    if (newCamera != null) {
      await initializeController(newCamera);
    }
  }
  
  /// Dispose camera resources
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    
    state = AsyncData(
      CameraState(
        cameras: _cameras,
        isInitialized: false,
      ),
    );
  }
}

/// Camera state model
class CameraState {
  final List<CameraDescription> cameras;
  final bool isInitialized;
  final CameraController? currentController;
  final CameraDescription? currentCamera;
  final bool isRecording;
  
  const CameraState({
    required this.cameras,
    required this.isInitialized,
    this.currentController,
    this.currentCamera,
    this.isRecording = false,
  });
  
  CameraState copyWith({
    List<CameraDescription>? cameras,
    bool? isInitialized,
    CameraController? currentController,
    CameraDescription? currentCamera,
    bool? isRecording,
  }) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      isInitialized: isInitialized ?? this.isInitialized,
      currentController: currentController ?? this.currentController,
      currentCamera: currentCamera ?? this.currentCamera,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}