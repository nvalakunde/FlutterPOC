class ReceiptList {
  List<String> ayList;
  List<String> fees_type;
  List<Learner> learners;
  List<Receipt> receipts;
  String currentAY;
  ReceiptList({
    this.ayList, this.currentAY, this.fees_type,this.learners,
    this.receipts,
  });
  factory ReceiptList.fromJson(Map<String, dynamic> parsedJson) {
    List<String> aysList;
    List<String> frList;
    List<Learner> learnerList;
    List<Receipt> recpList;
    var list = parsedJson['ay_list'] as List;
    if (list != null) {
      aysList = List<String>();
      for (var ay in list) {
        aysList.add(ay.toString());
      }
    }
    list = parsedJson['fees_type'] as List;
    if (list != null) {
      frList = List<String>();
      for (var ay in list) {
        frList.add(ay.toString());
      }
    }
    list = parsedJson['learners'] as List;
    if (list != null) {
      learnerList = List<Learner>();
      
      for (var ay in list) {
        Learner temp=Learner.fromJson(ay);
        learnerList.add(temp);
      }
    }
    list = parsedJson['receipt_list'] as List;
    if (list != null) {
      recpList = List<Receipt>();
      
      for (var recpt in list) {
        print("***** recpt *****");
        print(recpt);
        Receipt temp=Receipt.fromJson(recpt);
        recpList.add(temp);
      }
    }
    return ReceiptList(
      currentAY: parsedJson['curr_ay'],
        ayList: aysList,
        fees_type: frList,
        learners: learnerList,
        receipts: recpList,
    );
  }
}




class Learner {
  String name;
  int id;
  Learner({
    this.name,
    this.id,
  });
  factory Learner.fromJson(Map<String, dynamic> parsedJson) {
    return Learner(
      name: parsedJson['name'],
      id: parsedJson['id'],
    );
  }
}
class Receipt {
  String amount;
  String standard;
  String receiptNo;
  String receiptDate;
  int id;
  Receipt({
    this.amount,
    this.standard,
    this.receiptNo,
    this.receiptDate,
    this.id,
  });
  factory Receipt.fromJson(Map<String, dynamic> parsedJson) {
    return Receipt(
      amount: parsedJson['amount'].toString(),
      standard: parsedJson['std'],
      receiptNo: parsedJson['receipt_no'],
      receiptDate: parsedJson['receipt_date'],
      id: parsedJson['id'],
    );
  }
}
class admissionfeesreceiptmodel {
  String showStatus;
  String enableStatus;
  List<Complist> subMenuList;
  List<Receiptdata> subMenuList1;
  List<Translist> subMenuList2;
  admissionfeesreceiptmodel({
    this.showStatus,
    this.enableStatus,
    this.subMenuList,
    this.subMenuList1,
    this.subMenuList2,
  });
  factory admissionfeesreceiptmodel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['comp_list'] as List;
    List<Complist> subMenuLists =
        list.map((i) => Complist.fromJson(i)).toList();
    var list1 = parsedJson['receipt_data'] as List;
    List<Receiptdata> subMenuLists1 =
        list1.map((i) => Receiptdata.fromJson(i)).toList();
    var list2 = parsedJson['trans_list'] as List;
    List<Translist> subMenuLists2 =
        list2.map((i) => Translist.fromJson(i)).toList();
    return admissionfeesreceiptmodel(
      showStatus: parsedJson['to_show'],
      enableStatus: parsedJson['enable_submit'],
      subMenuList: subMenuLists,
      subMenuList1: subMenuLists1,
      subMenuList2: subMenuLists2,
    );
  }
}




class Complist {
  var amount;
  String name;
  Complist({
    this.amount,
    this.name,
  });
  factory Complist.fromJson(Map<String, dynamic> parsedJson) {
    return Complist(
      amount: parsedJson['amount'],
      name: parsedJson['name'],
    );
  }
}

class Receiptdata {
  String receipt_no;
  String stud_name;
  String receipt_date;
  String ay;
  var receipt_id;
  var receipt_amount;
  String stud_reg_no;
  Receiptdata({
    this.receipt_no,
    this.stud_name,
    this.receipt_date,
    this.ay,
    this.receipt_id,
    this.receipt_amount,
    this.stud_reg_no,
  });
  factory Receiptdata.fromJson(Map<String, dynamic> parsedJson) {
    return Receiptdata(
      receipt_no: parsedJson['receipt_no'],
      stud_name: parsedJson['stud_name'],
      receipt_date: parsedJson['receipt_date'],
      ay: parsedJson['ay'],
      receipt_id: parsedJson['receipt_id'],
      receipt_amount: parsedJson['receipt_amount'],
      stud_reg_no: parsedJson['stud_reg_no'],
    );
  }
}

class Translist {
  String date;
  String mode;
  var amount;
  String bank;
  var transid;

  Translist({this.date, this.mode, this.amount, this.bank, this.transid});
  factory Translist.fromJson(Map<String, dynamic> parsedJson) {
    return Translist(
      date: parsedJson['date'],
      mode: parsedJson['mode'],
      amount: parsedJson['amount'],
      bank: parsedJson['bank'],
      transid: parsedJson['transid'],
    );
  }
}
