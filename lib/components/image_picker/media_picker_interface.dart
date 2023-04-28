import 'media_file.dart';

abstract class MediaPickerController {
  Future<bool> pickMedias();

  void reOrderMedia(int oldIndex, int newIndex);

  void addMedia(MediaFile mediaFile);

  void removeMedia(MediaFile mediaFile);

  void clearMedias();
}