import 'dart:convert';

///Represents a break (e.g. ad break)
///included in the main video.
class CastBreak {
  ///List of break clip IDs included in this break.

  final List<String> breakClipIds;

  ///Duration of break in seconds.
  final Duration? duration;

  ///Unique ID of a break.
  final String id;

  /// Indicates whether the break is embedded in the main stream.

  final bool isEmbedded;

  /// Whether a break was watched. This is marked as
  ///  true when the break begins to play.
  /// A sender can change color of a progress
  ///  bar marker corresponding to this break
  /// once this field changes from false to
  /// true denoting that the end-user
  /// already watched this break.

  final bool isWatched;

  ///Location of the break inside the main video. -1 represents the end of the main video in seconds.

  final int position;
  CastBreak({
    required this.breakClipIds,
    this.duration,
    required this.id,
    required this.isEmbedded,
    required this.isWatched,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'breakClipIds': breakClipIds,
      'duration': duration?.inSeconds,
      'id': id,
      'isEmbedded': isEmbedded,
      'isWatched': isWatched,
      'position': position,
    };
  }

  factory CastBreak.fromMap(Map<String, dynamic> map) {
    dynamic duration = map['duration'];
    if(duration != null && duration is num) {
      duration =  Duration(seconds: duration.isFinite ? duration.round() : 0);
    }else {
      duration = null;
    }
    return CastBreak(
      breakClipIds: List<String>.from(map['breakClipIds']),
      duration: duration,
      id: map['id'] ?? '',
      isEmbedded: map['isEmbedded'] ?? false,
      isWatched: map['isWatched'] ?? false,
      position: map['position']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CastBreak.fromJson(String source) =>
      CastBreak.fromMap(json.decode(source));
}
