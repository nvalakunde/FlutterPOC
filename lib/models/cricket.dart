class Cricketer {
  String name;
  int first;
  int last;
  String runs;
  String hS;

  Cricketer({this.name, this.first, this.last, this.runs, this.hS});

  Cricketer.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    first = json['First'];
    last = json['Last'];
    runs = json['Runs'];
    hS = json['HS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['First'] = this.first;
    data['Last'] = this.last;
    data['Runs'] = this.runs;
    data['HS'] = this.hS;
    return data;
  }
}