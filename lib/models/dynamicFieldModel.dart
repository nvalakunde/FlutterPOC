class DynamicField {
  String fieldName;
  int limit;
  String value;
  bool isShow;
  bool isApplicable;
  String type;
  bool isMandatory;

  DynamicField(
      {this.fieldName,
      this.limit,
      this.value,
      this.isShow,
      this.isApplicable,
      this.type,
      this.isMandatory});

  DynamicField.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    limit = json['limit'];
    value = json['value'].toString();
    isShow = json['isShow'];
    isApplicable = json['isApplicable'];
    type = json['type'];
    isMandatory = json['isMandatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['limit'] = this.limit;
    data['value'] = this.value;
    data['isShow'] = this.isShow;
    data['isApplicable'] = this.isApplicable;
    data['type'] = this.type;
    data['isMandatory'] = this.isMandatory;
    return data;
  }
}
