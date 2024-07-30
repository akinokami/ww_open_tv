class ChannelModel {
  String? countryCode;
  String? name;
  String? url;
  String? imageUrl;

  ChannelModel({this.name, this.url, this.imageUrl, this.countryCode});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    name = json['name'];
    url = json['url'];
    imageUrl = json['imageUrl'];
  }
Map<String,dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['countryCode'] = countryCode;
  data['name'] = name;
  data['url'] = url;
  data['imageUrl'] = imageUrl;
  return data;
}

}
