enum MediaType { image, video }

class MediaFile {
  MediaType mediaType;

  final String? path;

  final String? filePath;

  bool get hasPath => path != null;

  MediaFile({this.mediaType = MediaType.image,this.path, this.filePath});
}

