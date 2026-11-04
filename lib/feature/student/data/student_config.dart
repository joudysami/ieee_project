import 'package:ieee/core/helpers/cache_help.dart';

/// Student-only configuration.
class StudentConfig {
  StudentConfig._();

  // TODO(temporary): Remove [defaultTrackId] and the fallback in
  // [resolveTrackId] once the backend always returns the authenticated
  // student's trackId. Use only [CacheHelp.trackIdInt] after that.
  static const int defaultTrackId = 1;

  /// Prefers the authenticated student's trackId; falls back to
  /// [defaultTrackId] only when it is null/unavailable.
  static int resolveTrackId() => CacheHelp.trackIdInt ?? defaultTrackId;
}
