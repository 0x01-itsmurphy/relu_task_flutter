class MusicListModel {
  final Message? message;

  MusicListModel({
    this.message,
  });

  MusicListModel.fromJson(Map<String, dynamic> json)
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
  final List<TrackList>? trackList;

  Body({
    this.trackList,
  });

  Body.fromJson(Map<String, dynamic> json)
      : trackList = (json['track_list'] as List?)
            ?.map((dynamic e) => TrackList.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'track_list': trackList?.map((e) => e.toJson()).toList()};
}

class TrackList {
  final Track? track;

  TrackList({
    this.track,
    required MusicListModel musicList,
  });

  TrackList.fromJson(Map<String, dynamic> json)
      : track = (json['track'] as Map<String, dynamic>?) != null
            ? Track.fromJson(json['track'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'track': track?.toJson()};
}

class Track {
  int? trackId;
  String? trackName;
  final List<dynamic>? trackNameTranslationList;
  final int? trackRating;
  final int? commontrackId;
  final int? instrumental;
  final int? explicit;
  final int? hasLyrics;
  final int? hasSubtitles;
  final int? hasRichsync;
  final int? numFavourite;
  final int? albumId;
   String? albumName;
  final int? artistId;
  String? artistName;
  final String? trackShareUrl;
  final String? trackEditUrl;
  final int? restricted;
  final String? updatedTime;
  final PrimaryGenres? primaryGenres;

  Track({
    this.trackId,
    this.trackName,
    this.trackNameTranslationList,
    this.trackRating,
    this.commontrackId,
    this.instrumental,
    this.explicit,
    this.hasLyrics,
    this.hasSubtitles,
    this.hasRichsync,
    this.numFavourite,
    this.albumId,
    this.albumName,
    this.artistId,
    this.artistName,
    this.trackShareUrl,
    this.trackEditUrl,
    this.restricted,
    this.updatedTime,
    this.primaryGenres,
  });

  Track.fromJson(Map<String, dynamic> json)
      : trackId = json['track_id'] as int?,
        trackName = json['track_name'] as String?,
        trackNameTranslationList = json['track_name_translation_list'] as List?,
        trackRating = json['track_rating'] as int?,
        commontrackId = json['commontrack_id'] as int?,
        instrumental = json['instrumental'] as int?,
        explicit = json['explicit'] as int?,
        hasLyrics = json['has_lyrics'] as int?,
        hasSubtitles = json['has_subtitles'] as int?,
        hasRichsync = json['has_richsync'] as int?,
        numFavourite = json['num_favourite'] as int?,
        albumId = json['album_id'] as int?,
        albumName = json['album_name'] as String?,
        artistId = json['artist_id'] as int?,
        artistName = json['artist_name'] as String?,
        trackShareUrl = json['track_share_url'] as String?,
        trackEditUrl = json['track_edit_url'] as String?,
        restricted = json['restricted'] as int?,
        updatedTime = json['updated_time'] as String?,
        primaryGenres =
            (json['primary_genres'] as Map<String, dynamic>?) != null
                ? PrimaryGenres.fromJson(
                    json['primary_genres'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'track_id': trackId,
        'track_name': trackName,
        'track_name_translation_list': trackNameTranslationList,
        'track_rating': trackRating,
        'commontrack_id': commontrackId,
        'instrumental': instrumental,
        'explicit': explicit,
        'has_lyrics': hasLyrics,
        'has_subtitles': hasSubtitles,
        'has_richsync': hasRichsync,
        'num_favourite': numFavourite,
        'album_id': albumId,
        'album_name': albumName,
        'artist_id': artistId,
        'artist_name': artistName,
        'track_share_url': trackShareUrl,
        'track_edit_url': trackEditUrl,
        'restricted': restricted,
        'updated_time': updatedTime,
        'primary_genres': primaryGenres?.toJson()
      };
}

class PrimaryGenres {
  final List<MusicGenreList>? musicGenreList;

  PrimaryGenres({
    this.musicGenreList,
  });

  PrimaryGenres.fromJson(Map<String, dynamic> json)
      : musicGenreList = (json['music_genre_list'] as List?)
            ?.map((dynamic e) =>
                MusicGenreList.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'music_genre_list': musicGenreList?.map((e) => e.toJson()).toList()};
}

class MusicGenreList {
  final MusicGenre? musicGenre;

  MusicGenreList({
    this.musicGenre,
  });

  MusicGenreList.fromJson(Map<String, dynamic> json)
      : musicGenre = (json['music_genre'] as Map<String, dynamic>?) != null
            ? MusicGenre.fromJson(json['music_genre'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'music_genre': musicGenre?.toJson()};
}

class MusicGenre {
  final int? musicGenreId;
  final int? musicGenreParentId;
  final String? musicGenreName;
  final String? musicGenreNameExtended;
  final String? musicGenreVanity;

  MusicGenre({
    this.musicGenreId,
    this.musicGenreParentId,
    this.musicGenreName,
    this.musicGenreNameExtended,
    this.musicGenreVanity,
  });

  MusicGenre.fromJson(Map<String, dynamic> json)
      : musicGenreId = json['music_genre_id'] as int?,
        musicGenreParentId = json['music_genre_parent_id'] as int?,
        musicGenreName = json['music_genre_name'] as String?,
        musicGenreNameExtended = json['music_genre_name_extended'] as String?,
        musicGenreVanity = json['music_genre_vanity'] as String?;

  Map<String, dynamic> toJson() => {
        'music_genre_id': musicGenreId,
        'music_genre_parent_id': musicGenreParentId,
        'music_genre_name': musicGenreName,
        'music_genre_name_extended': musicGenreNameExtended,
        'music_genre_vanity': musicGenreVanity
      };
}
