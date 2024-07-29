// class CountryModel {
//   int? id;
//   String? name;
//   String? code;

//   CountryModel({this.id, this.name, this.code});
// }

class CountryModel {
  String? name;
  String? code;
  List<String>? languages;
  String? flag;

  CountryModel({this.name, this.code, this.languages, this.flag});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    languages = json['languages'].cast<String>();
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['languages'] = languages;
    data['flag'] = flag;
    return data;
  }
}
