class MusicLyricsModel {
  final Message? message;

  MusicLyricsModel({
    this.message,
  });

  MusicLyricsModel.fromJson(Map<String, dynamic> json)
      : message = (json['message'] as Map<String, dynamic>?) != null
            ? Message.fromJson(json['message'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'message': message?.toJson()};
}

class Message {
  final Header? header;
  final Body? body;

  Message({
    this.header,
    this.body,
  });

  Message.fromJson(Map<String, dynamic> json)
      : header = (json['header'] as Map<String, dynamic>?) != null
            ? Header.fromJson(json['header'] as Map<String, dynamic>)
            : null,
        body = (json['body'] as Map<String, dynamic>?) != null
            ? Body.fromJson(json['body'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'header': header?.toJson(), 'body': body?.toJson()};
}

class Header {
  final int? statusCode;
  final double? executeTime;

  Header({
    this.statusCode,
    this.executeTime,
  });

  Header.fromJson(Map<String, dynamic> json)
      : statusCode = json['status_code'] as int?,
        executeTime = json['execute_time'] as double?;

  Map<String, dynamic> toJson() =>
      {'status_code': statusCode, 'execute_time': executeTime};
}

class Body {
  final Lyrics? lyrics;

  Body({
    this.lyrics,
  });

  Body.fromJson(Map<String, dynamic> json)
      : lyrics = (json['lyrics'] as Map<String, dynamic>?) != null
            ? Lyrics.fromJson(json['lyrics'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'lyrics': lyrics?.toJson()};
}

class Lyrics {
  final int? lyricsId;
  final int? explicit;
  final String? lyricsBody;
  final String? scriptTrackingUrl;
  final String? pixelTrackingUrl;
  final String? lyricsCopyright;
  final String? updatedTime;

  Lyrics({
    this.lyricsId,
    this.explicit,
    this.lyricsBody,
    this.scriptTrackingUrl,
    this.pixelTrackingUrl,
    this.lyricsCopyright,
    this.updatedTime,
  });

  Lyrics.fromJson(Map<String, dynamic> json)
      : lyricsId = json['lyrics_id'] as int?,
        explicit = json['explicit'] as int?,
        lyricsBody = json['lyrics_body'] as String?,
        scriptTrackingUrl = json['script_tracking_url'] as String?,
        pixelTrackingUrl = json['pixel_tracking_url'] as String?,
        lyricsCopyright = json['lyrics_copyright'] as String?,
        updatedTime = json['updated_time'] as String?;

  Map<String, dynamic> toJson() => {
        'lyrics_id': lyricsId,
        'explicit': explicit,
        'lyrics_body': lyricsBody,
        'script_tracking_url': scriptTrackingUrl,
        'pixel_tracking_url': pixelTrackingUrl,
        'lyrics_copyright': lyricsCopyright,
        'updated_time': updatedTime
      };
}
