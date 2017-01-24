library dart_analysis_client.config;

import 'dart:io';
import 'package:path/path.dart' as path;

/// Data class that contains analyzer configuration
class AnalyzerConfig {
  /// Should checked mode be used?
  bool useChecked = false;

  /// Should diagnostics be enabled?
  bool startWithDiagnostics = false;

  /// [Directory] od Dart SDK base
  final Directory directory;

  /// Path of Dart SDK base
  String get sdkPath => directory.path;

  AnalyzerConfig(this.directory);

  /// Binary
  //TODO dart.exe for windows
  String get dartVMPath => path.join(sdkPath, 'bin', 'dart');

  String getSnapshotPath(String snapshotName) =>
      path.join(sdkPath, 'bin', 'snapshots', snapshotName);

  String getAnalysisServerSnapshotPath() =>
      getSnapshotPath(analysisServerSnapshotName);

  static const String analysisServerSnapshotName =
      'analysis_server.dart.snapshot';

  static const int diagnosticsPort = 23072;
}