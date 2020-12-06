class DynamicField {
  String fieldName;
  int limit;
  String value;
  bool isShow;
  bool isApplicable;
  String inputType;
  bool isMandatory;
  String feildType;
  List<ListData> listData;
  String fileName;
  String filePath;

  DynamicField(
      {this.fieldName,
      this.limit,
      this.value,
      this.isShow,
      this.isApplicable,
      this.inputType,
      this.isMandatory,
      this.feildType,
      this.listData,
      this.fileName,
      this.filePath});

  DynamicField.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    limit = json['limit'];
    value = json['value'].toString();
    isShow = json['isShow'];
    isApplicable = json['isApplicable'];
    inputType = json['inputType'];
    isMandatory = json['isMandatory'];
    feildType = json['feildType'];
    if (json['listData'] != null) {
      listData = new List<ListData>();
      json['listData'].forEach((v) {
        listData.add(new ListData.fromJson(v));
      });
    }
    fileName = json['fileName'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['limit'] = this.limit;
    data['value'] = this.value;
    data['isShow'] = this.isShow;
    data['isApplicable'] = this.isApplicable;
    data['inputType'] = this.inputType;
    data['isMandatory'] = this.isMandatory;
    data['feildType'] = this.feildType;
    if (this.listData != null) {
      data['listData'] = this.listData.map((v) => v.toJson()).toList();
    }
    data['fileName'] = this.fileName;
    data['filePath'] = this.filePath;
    return data;
  }
}

class ListData {
  String name;
  bool selected;

  ListData({this.name, this.selected});

  ListData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['selected'] = this.selected;
    return data;
  }
}
