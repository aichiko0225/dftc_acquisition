import 'package:dftc_acquisition/utils/ssi_logger.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'media_file.dart';
import 'media_picker_interface.dart';

class ImagePickerController extends MediaPickerController with ChangeNotifier {
  final int maxCount;

  late final List<MediaFile> _fileArray;

  /// Returns [Iterable] of [ImageFile] that user has selected.
  Iterable<MediaFile> get fileArray => _fileArray;

  /// Returns true if user has selected no images.
  bool get hasNoFile => _fileArray.isEmpty;

  ImagePickerController({this.maxCount = 6, Iterable<MediaFile>? fileArr}) {
    if (fileArr != null) {
      _fileArray = List.from(fileArr);
    } else {
      _fileArray = [];
    }
  }

  /// manually pick images. i.e. on click on external button.
  /// this method open Image picking window.
  /// It returns [Future] of [bool], true if user has selected images.
  @override
  Future<bool> pickMedias() async {
    var status = await Permission.photos.status;
    SsiLogger.d(status);
    if (status.isDenied) {
      var new_status = await Permission.photos.request();
      if (new_status.isGranted) {
        final ImagePicker picker = ImagePicker();
        var imageArr = await picker.pickMultiImage();

        // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      }
    } else if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      var imageArr = await picker.pickMultiImage();
      SsiLogger.d(imageArr);
    } else {

    }
    return false;
  }

  void _addMedias(Iterable<MediaFile> fileArr) {
    int i = 0;
    while (_fileArray.length < maxCount && fileArr.length > i) {
      _fileArray.add(fileArr.elementAt(i));
      i++;
    }
  }

  /// Manually re-order image, i.e. move image from one position to another position.
  @override
  void reOrderMedia(int oldIndex, int newIndex) {
    final oldItem = _fileArray.removeAt(oldIndex);
    _fileArray.insert(newIndex, oldItem);
    notifyListeners();
  }

  @override
  void addMedia(MediaFile mediaFile) {
    _fileArray.add(mediaFile);
    notifyListeners();
  }

  /// Manually remove image from list.
  @override
  void removeMedia(MediaFile mediaFile) {
    _fileArray.remove(mediaFile);
    notifyListeners();
  }

  /// Remove all selected images and show default UI
  void clearMedias() {
    _fileArray.clear();
    notifyListeners();
  }
}
