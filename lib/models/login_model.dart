class CaptchaImageModel {
  String? img;
  String? uuid;

  CaptchaImageModel({
    this.img,
    this.uuid,
  });

  factory CaptchaImageModel.fromJson(Map<String, dynamic> json) => CaptchaImageModel(
    img: json["img"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "uuid": uuid,
  };
}