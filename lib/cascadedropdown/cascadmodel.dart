class StateModel {
  String state;
  List<String> cityList;

  StateModel({this.state, this.cityList});

  StateModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    cityList = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['cities'] = this.cityList;
    return data;
  }
}