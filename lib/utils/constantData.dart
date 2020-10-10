// String emailRegex=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/taskmanagement/Model/category.dart';
import 'package:url_launcher/url_launcher.dart';

RegExp emailRegex = new RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
RegExp mobileRegex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

List<Category> categoryList = List<Category>();


Widget companyLogo(String url, double height, double width) {
  return FadeInImage(
    height: height,
    width: width,
    image: NetworkImage(url),
    placeholder: AssetImage("assets/images/default-image.jpg"),
    fit: BoxFit.scaleDown,
  );
}

Future<DateTime> selectDate(BuildContext context) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 1),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    return picked;
  }
}

Future<TimeOfDay> selectTime(BuildContext context) async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
  );
  if (picked != null) {
    return picked;
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget toastFunstion(BuildContext context, String msg) {
  return Flushbar(
    margin: EdgeInsets.only(
        left: setWidth(15), right: setWidth(15), bottom: setHeight(50)),
    borderRadius: setHeight(8),
    flushbarStyle: FlushbarStyle.FLOATING,
    // message: msg,
    messageText: Text(
      msg,
      style: txtStyle(
        16,
        Colors.white,
      ),
    ),

    duration: Duration(seconds: 5),
  )..show(context);
}


var cricketerList=""" [
 {
   "Name": "Amar Singh",
   "First": 1932,
   "Last": 1936,
   "Runs": "292",
   "HS": "51"
 },
 {
   "Name": "Sorabji Colah",
   "First": 1932,
   "Last": 1933,
   "Runs": "69",
   "HS": "31"
 },
 {
   "Name": "Jahangir Khan",
   "First": 1932,
   "Last": 1936,
   "Runs": "39",
   "HS": "13"
 },
 {
   "Name": "Lall Singh",
   "First": 1932,
   "Last": 1932,
   "Runs": "44",
   "HS": "29"
 },
 {
   "Name": "Naoomal Jeoomal",
   "First": 1932,
   "Last": 1934,
   "Runs": "108",
   "HS": "43"
 },
 {
   "Name": "Janardan Navle",
   "First": 1932,
   "Last": 1933,
   "Runs": "42",
   "HS": "13"
 },
 {
   "Name": "C. K. Nayudu",
   "First": 1932,
   "Last": 1936,
   "Runs": "350",
   "HS": "81"
 },
 {
   "Name": "Nazir Ali",
   "First": 1932,
   "Last": 1934,
   "Runs": "30",
   "HS": "13"
 },
 {
   "Name": "Mohammad Nissar",
   "First": 1932,
   "Last": 1936,
   "Runs": "55",
   "HS": "14"
 },
 {
   "Name": "Phiroze Palia",
   "First": 1932,
   "Last": 1936,
   "Runs": "29",
   "HS": "16"
 },
 {
   "Name": "Wazir Ali",
   "First": 1932,
   "Last": 1936,
   "Runs": "237",
   "HS": "42"
 },
 {
   "Name": "Lala Amarnath",
   "First": 1933,
   "Last": 1952,
   "Runs": "878",
   "HS": "118"
 },
 {
   "Name": "L. P. Jai",
   "First": 1933,
   "Last": 1933,
   "Runs": "19",
   "HS": "19"
 },
 {
   "Name": "Rustomji Jamshedji",
   "First": 1933,
   "Last": 1933,
   "Runs": "5",
   "HS": "4*"
 },
 {
   "Name": "Vijay Merchant",
   "First": 1933,
   "Last": 1951,
   "Runs": "859",
   "HS": "154"
 },
 {
   "Name": "Ladha Ramji",
   "First": 1933,
   "Last": 1933,
   "Runs": "1",
   "HS": "1"
 },
 {
   "Name": "Dilawar Hussain",
   "First": 1934,
   "Last": 1936,
   "Runs": "254",
   "HS": "59"
 },
 {
   "Name": "M. J. Gopalan",
   "First": 1934,
   "Last": 1934,
   "Runs": "18",
   "HS": "11*"
 },
 {
   "Name": "Mushtaq Ali",
   "First": 1934,
   "Last": 1952,
   "Runs": "612",
   "HS": "112"
 },
 {
   "Name": "C. S. Nayudu",
   "First": 1934,
   "Last": 1952,
   "Runs": "147",
   "HS": "36"
 },
 {
   "Name": "Yadavindra Singh",
   "First": 1934,
   "Last": 1934,
   "Runs": "84",
   "HS": "60"
 },
 {
   "Name": "Dattaram Hindlekar",
   "First": 1936,
   "Last": 1946,
   "Runs": "71",
   "HS": "26"
 },
 {
   "Name": "Vijay Ananda Gajapathi Raju",
   "First": 1936,
   "Last": 1936,
   "Runs": "33",
   "HS": "19*"
 },
 {
   "Name": "Khershed Meherhomji",
   "First": 1936,
   "Last": 1936,
   "Runs": "0",
   "HS": "0*"
 },
 {
   "Name": "Cotah Ramaswami",
   "First": 1936,
   "Last": 1936,
   "Runs": "170",
   "HS": "60"
 },
 {
   "Name": "Baqa Jilani",
   "First": 1936,
   "Last": 1936,
   "Runs": "16",
   "HS": "12"
 },
 {
   "Name": "Gul Mohammad[4]",
   "First": 1946,
   "Last": 1952,
   "Runs": "166",
   "HS": "34"
 },
 {
   "Name": "Vijay Hazare",
   "First": 1946,
   "Last": 1953,
   "Runs": "2192",
   "HS": "164*"
 },
 {
   "Name": "Abdul Hafeez[6]",
   "First": 1946,
   "Last": 1946,
   "Runs": "80",
   "HS": "43"
 },
 {
   "Name": "Vinoo Mankad",
   "First": 1946,
   "Last": 1959,
   "Runs": "2109",
   "HS": "231"
 },
 {
   "Name": "Rusi Modi",
   "First": 1946,
   "Last": 1952,
   "Runs": "736",
   "HS": "112"
 },
 {
   "Name": "Nawab of Pataudi Sr",
   "First": 1946,
   "Last": 1946,
   "Runs": "55",
   "HS": "22"
 },
 {
   "Name": "Sadashiv Shinde",
   "First": 1946,
   "Last": 1952,
   "Runs": "85",
   "HS": "14"
 },
 {
   "Name": "Chandu Sarwate",
   "First": 1946,
   "Last": 1951,
   "Runs": "208",
   "HS": "37"
 },
 {
   "Name": "Ranga Sohoni",
   "First": 1946,
   "Last": 1951,
   "Runs": "83",
   "HS": "29*"
 },
 {
   "Name": "Hemu Adhikari",
   "First": 1947,
   "Last": 1959,
   "Runs": "872",
   "HS": "114*"
 },
 {
   "Name": "Jenni Irani",
   "First": 1947,
   "Last": 1947,
   "Runs": "3",
   "HS": "2*"
 },
 {
   "Name": "Gogumal Kishenchand",
   "First": 1947,
   "Last": 1952,
   "Runs": "89",
   "HS": "44"
 },
 {
   "Name": "Khandu Rangnekar",
   "First": 1947,
   "Last": 1948,
   "Runs": "33",
   "HS": "18"
 },
 {
   "Name": "Amir Elahi",
   "First": 1947,
   "Last": 1947,
   "Runs": "17",
   "HS": "13"
 },
 {
   "Name": "Dattu Phadkar",
   "First": 1947,
   "Last": 1959,
   "Runs": "1229",
   "HS": "123"
 },
 {
   "Name": "Kanwar Rai Singh",
   "First": 1948,
   "Last": 1948,
   "Runs": "26",
   "HS": "24"
 },
 {
   "Name": "Probir Sen",
   "First": 1948,
   "Last": 1952,
   "Runs": "165",
   "HS": "25"
 },
 {
   "Name": "C. R. Rangachari",
   "First": 1948,
   "Last": 1948,
   "Runs": "8",
   "HS": "8*"
 },
 {
   "Name": "Khanmohammad Ibrahim",
   "First": 1948,
   "Last": 1949,
   "Runs": "169",
   "HS": "85"
 },
 {
   "Name": "Keki Tarapore",
   "First": 1948,
   "Last": 1948,
   "Runs": "2",
   "HS": "2"
 },
 {
   "Name": "Polly Umrigar",
   "First": 1948,
   "Last": 1962,
   "Runs": "3631",
   "HS": "223"
 },
 {
   "Name": "Montu Banerjee",
   "First": 1949,
   "Last": 1949,
   "Runs": "0",
   "HS": "0"
 },
 {
   "Name": "Ghulam Ahmed",
   "First": 1949,
   "Last": 1959,
   "Runs": "192",
   "HS": "50"
 },
 {
   "Name": "Nirode Chowdhury",
   "First": 1949,
   "Last": 1951,
   "Runs": "3",
   "HS": "3*"
 },
 {
   "Name": "Madhusudan Rege",
   "First": 1949,
   "Last": 1949,
   "Runs": "15",
   "HS": "15"
 },
 {
   "Name": "Shute Banerjee",
   "First": 1949,
   "Last": 1949,
   "Runs": "13",
   "HS": "8"
 },
 {
   "Name": "Nana Joshi",
   "First": 1951,
   "Last": 1960,
   "Runs": "207",
   "HS": "52*"
 },
 {
   "Name": "Pankaj Roy",
   "First": 1951,
   "Last": 1960,
   "Runs": "2442",
   "HS": "173"
 },
 {
   "Name": "C. D. Gopinath",
   "First": 1951,
   "Last": 1960,
   "Runs": "242",
   "HS": "50*"
 },
 {
   "Name": "Madhav Mantri",
   "First": 1951,
   "Last": 1955,
   "Runs": "67",
   "HS": "39"
 },
 {
   "Name": "Buck Divecha",
   "First": 1952,
   "Last": 1952,
   "Runs": "60",
   "HS": "26"
 },
 {
   "Name": "Subhash Gupte",
   "First": 1952,
   "Last": 1961,
   "Runs": "183",
   "HS": "21"
 },
 {
   "Name": "Vijay Manjrekar",
   "First": 1952,
   "Last": 1965,
   "Runs": "3208",
   "HS": "189*"
 },
 {
   "Name": "Datta Gaekwad",
   "First": 1952,
   "Last": 1961,
   "Runs": "350",
   "HS": "52"
 },
 {
   "Name": "Gulabrai Ramchand",
   "First": 1952,
   "Last": 1960,
   "Runs": "1180",
   "HS": "109"
 },
 {
   "Name": "Hiralal Gaekwad",
   "First": 1952,
   "Last": 1952,
   "Runs": "22",
   "HS": "14"
 },
 {
   "Name": "Shah Nyalchand",
   "First": 1952,
   "Last": 1952,
   "Runs": "7",
   "HS": "6*"
 },
 {
   "Name": "Madhav Apte",
   "First": 1952,
   "Last": 1953,
   "Runs": "542",
   "HS": "163*"
 },
 {
   "Name": "Bal Dani",
   "First": 1952,
   "Last": 1952,
   "Runs": "-",
   "HS": "-"
 },
 {
   "Name": "Vijay Rajindernath",
   "First": 1952,
   "Last": 1952,
   "Runs": "-",
   "HS": "-"
 },
 {
   "Name": "Ebrahim Maka",
   "First": 1952,
   "Last": 1953,
   "Runs": "2",
   "HS": "2*"
 },
 {
   "Name": "Deepak Shodhan",
   "First": 1952,
   "Last": 1953,
   "Runs": "181",
   "HS": "110"
 },
 {
   "Name": "Chandrasekhar Gadkari",
   "First": 1953,
   "Last": 1955,
   "Runs": "129",
   "HS": "50*"
 },
 {
   "Name": "Jayasinghrao Ghorpade",
   "First": 1953,
   "Last": 1959,
   "Runs": "229",
   "HS": "41"
 },
 {
   "Name": "Pananmal Punjabi",
   "First": 1955,
   "Last": 1955,
   "Runs": "164",
   "HS": "33"
 },
 {
   "Name": "Naren Tamhane",
   "First": 1955,
   "Last": 1961,
   "Runs": "225",
   "HS": "54*"
 },
 {
   "Name": "Prakash Bhandari",
   "First": 1955,
   "Last": 1956,
   "Runs": "77",
   "HS": "39"
 },
 {
   "Name": "Jasu Patel",
   "First": 1955,
   "Last": 1960,
   "Runs": "25",
   "HS": "12"
 },
 {
   "Name": "A. G. Kripal Singh",
   "First": 1955,
   "Last": 1964,
   "Runs": "422",
   "HS": "100*"
 },
 {
   "Name": "Narain Swamy",
   "First": 1955,
   "Last": 1955,
   "Runs": "-",
   "HS": "-"
 },
 {
   "Name": "Nari Contractor",
   "First": 1955,
   "Last": 1962,
   "Runs": "1611",
   "HS": "108"
 },
 {
   "Name": "Vijay Mehra",
   "First": 1955,
   "Last": 1964,
   "Runs": "329",
   "HS": "62"
 },
 {
   "Name": "Sadashiv Patil",
   "First": 1955,
   "Last": 1955,
   "Runs": "14",
   "HS": "14*"
 },
 {
   "Name": "Bapu Nadkarni",
   "First": 1955,
   "Last": 1968,
   "Runs": "1414",
   "HS": "122*"
 },
 {
   "Name": "Gundibail Sunderam",
   "First": 1955,
   "Last": 1956,
   "Runs": "3",
   "HS": "3*"
 },
 {
   "Name": "Chandrakant Patankar",
   "First": 1956,
   "Last": 1956,
   "Runs": "14",
   "HS": "13"
 },
 {
   "Name": "Chandu Borde",
   "First": 1958,
   "Last": 1969,
   "Runs": "3061",
   "HS": "177*"
 },
 {
   "Name": "Ghulam Guard",
   "First": 1958,
   "Last": 1960,
   "Runs": "11",
   "HS": "7"
 },
 {
   "Name": "Manohar Hardikar",
   "First": 1958,
   "Last": 1958,
   "Runs": "56",
   "HS": "32*"
 },
 {
   "Name": "Vasant Ranjane",
   "First": 1958,
   "Last": 1964,
   "Runs": "40",
   "HS": "16"
 },
 {
   "Name": "Ramnath Kenny",
   "First": 1959,
   "Last": 1960,
   "Runs": "245",
   "HS": "62"
 },
 {
   "Name": "Surendranath",
   "First": 1959,
   "Last": 1961,
   "Runs": "136",
   "HS": "27"
 },
 {
   "Name": "Apoorva Sengupta",
   "First": 1959,
   "Last": 1959,
   "Runs": "9",
   "HS": "8"
 },
 {
   "Name": "Ramakant Desai",
   "First": 1959,
   "Last": 1968,
   "Runs": "418",
   "HS": "85"
 },
 {
   "Name": "M. L. Jaisimha",
   "First": 1959,
   "Last": 1971,
   "Runs": "2056",
   "HS": "129"
 },
 {
   "Name": "Arvind Apte",
   "First": 1959,
   "Last": 1959,
   "Runs": "15",
   "HS": "8"
 },
 {
   "Name": "Abbas Ali Baig",
   "First": 1959,
   "Last": 1967,
   "Runs": "428",
   "HS": "112"
 },
 {
   "Name": "V. M. Muddiah",
   "First": 1959,
   "Last": 1960,
   "Runs": "11",
   "HS": "11"
 },
 {
   "Name": "Salim Durani",
   "First": 1960,
   "Last": 1973,
   "Runs": "1202",
   "HS": "104"
 },
 {
   "Name": "Budhi Kunderan",
   "First": 1960,
   "Last": 1967,
   "Runs": "981",
   "HS": "192"
 },
 {
   "Name": "A. G. Milkha Singh",
   "First": 1960,
   "Last": 1961,
   "Runs": "92",
   "HS": "35"
 },
 {
   "Name": "Man Sood",
   "First": 1960,
   "Last": 1960,
   "Runs": "3",
   "HS": "3"
 },
 {
   "Name": "Rusi Surti",
   "First": 1960,
   "Last": 1969,
   "Runs": "1263",
   "HS": "99"
 },
 {
   "Name": "Baloo Gupte",
   "First": 1961,
   "Last": 1965,
   "Runs": "28",
   "HS": "17*"
 },
 {
   "Name": "Vaman Kumar",
   "First": 1961,
   "Last": 1961,
   "Runs": "6",
   "HS": "6"
 },
 {
   "Name": "Farokh Engineer",
   "First": 1961,
   "Last": 1975,
   "Runs": "2611",
   "HS": "121"
 },
 {
   "Name": "Dilip Sardesai",
   "First": 1961,
   "Last": 1972,
   "Runs": "2001",
   "HS": "212"
 },
 {
   "Name": "Mansoor Ali Khan Pataudi",
   "First": 1961,
   "Last": 1975,
   "Runs": "2793",
   "HS": "203*"
 },
 {
   "Name": "E. A. S. Prasanna",
   "First": 1962,
   "Last": 1978,
   "Runs": "735",
   "HS": "37"
 },
 {
   "Name": "B. S. Chandrasekhar",
   "First": 1964,
   "Last": 1979,
   "Runs": "167",
   "HS": "22"
 },
 {
   "Name": "Rajinder Pal",
   "First": 1964,
   "Last": 1964,
   "Runs": "6",
   "HS": "3*"
 },
 {
   "Name": "Hanumant Singh",
   "First": 1964,
   "Last": 1969,
   "Runs": "686",
   "HS": "105"
 },
 {
   "Name": "Kumar Indrajitsinhji",
   "First": 1964,
   "Last": 1969,
   "Runs": "51",
   "HS": "23"
 },
 {
   "Name": "Srinivas Venkataraghavan",
   "First": 1965,
   "Last": 1983,
   "Runs": "748",
   "HS": "64"
 },
 {
   "Name": "Venkataraman Subramanya",
   "First": 1965,
   "Last": 1968,
   "Runs": "263",
   "HS": "75"
 },
 {
   "Name": "Ajit Wadekar",
   "First": 1966,
   "Last": 1974,
   "Runs": "2113",
   "HS": "143"
 },
 {
   "Name": "Bishan Singh Bedi",
   "First": 1967,
   "Last": 1979,
   "Runs": "656",
   "HS": "50*"
 },
 {
   "Name": "Subrata Guha",
   "First": 1967,
   "Last": 1969,
   "Runs": "17",
   "HS": "6"
 },
 {
   "Name": "Ramesh Saxena",
   "First": 1967,
   "Last": 1967,
   "Runs": "25",
   "HS": "16"
 },
 {
   "Name": "Abid Ali",
   "First": 1967,
   "Last": 1974,
   "Runs": "1018",
   "HS": "81"
 },
 {
   "Name": "Umesh Kulkarni",
   "First": 1967,
   "Last": 1968,
   "Runs": "13",
   "HS": "7"
 },
 {
   "Name": "Chetan Chauhan",
   "First": 1969,
   "Last": 1981,
   "Runs": "2084",
   "HS": "97"
 },
 {
   "Name": "Ashok Mankad",
   "First": 1969,
   "Last": 1978,
   "Runs": "991",
   "HS": "97"
 },
 {
   "Name": "Ajit Pai",
   "First": 1969,
   "Last": 1969,
   "Runs": "10",
   "HS": "9"
 },
 {
   "Name": "Ambar Roy",
   "First": 1969,
   "Last": 1969,
   "Runs": "91",
   "HS": "48"
 },
 {
   "Name": "Ashok Gandotra",
   "First": 1969,
   "Last": 1969,
   "Runs": "54",
   "HS": "18"
 },
 {
   "Name": "Eknath Solkar",
   "First": 1969,
   "Last": 1977,
   "Runs": "1068",
   "HS": "102"
 },
 {
   "Name": "Gundappa Viswanath",
   "First": 1969,
   "Last": 1983,
   "Runs": "6080",
   "HS": "222"
 },
 {
   "Name": "Mohinder Amarnath",
   "First": 1969,
   "Last": 1988,
   "Runs": "4378",
   "HS": "138"
 },
 {
   "Name": "Kenia Jayantilal",
   "First": 1971,
   "Last": 1971,
   "Runs": "5",
   "HS": "5"
 },
 {
   "Name": "Pochiah Krishnamurthy",
   "First": 1971,
   "Last": 1971,
   "Runs": "33",
   "HS": "20"
 },
 {
   "Name": "Sunil Gavaskar",
   "First": 1971,
   "Last": 1987,
   "Runs": "10122",
   "HS": "236*"
 },
 {
   "Name": "Ramnath Parkar",
   "First": 1972,
   "Last": 1973,
   "Runs": "80",
   "HS": "35"
 },
 {
   "Name": "Madan Lal",
   "First": 1974,
   "Last": 1986,
   "Runs": "1042",
   "HS": "74"
 },
 {
   "Name": "Brijesh Patel",
   "First": 1974,
   "Last": 1977,
   "Runs": "972",
   "HS": "115*"
 },
 {
   "Name": "Sudhir Naik",
   "First": 1974,
   "Last": 1975,
   "Runs": "141",
   "HS": "77"
 },
 {
   "Name": "Hemant Kanitkar",
   "First": 1974,
   "Last": 1974,
   "Runs": "111",
   "HS": "65"
 },
 {
   "Name": "Parthasarathy Sharma",
   "First": 1974,
   "Last": 1977,
   "Runs": "187",
   "HS": "54"
 },
 {
   "Name": "Anshuman Gaekwad",
   "First": 1975,
   "Last": 1985,
   "Runs": "1985",
   "HS": "201"
 },
 {
   "Name": "Karsan Ghavri",
   "First": 1975,
   "Last": 1981,
   "Runs": "913",
   "HS": "86"
 },
 {
   "Name": "Surinder Amarnath",
   "First": 1976,
   "Last": 1978,
   "Runs": "550",
   "HS": "124"
 },
 {
   "Name": "Syed Kirmani",
   "First": 1976,
   "Last": 1986,
   "Runs": "2759",
   "HS": "102"
 },
 {
   "Name": "Dilip Vengsarkar",
   "First": 1976,
   "Last": 1992,
   "Runs": "6868",
   "HS": "166"
 },
 {
   "Name": "Yajurvindra Singh",
   "First": 1977,
   "Last": 1979,
   "Runs": "109",
   "HS": "43*"
 },
 {
   "Name": "Kapil Dev",
   "First": 1978,
   "Last": 1994,
   "Runs": "5248",
   "HS": "163"
 },
 {
   "Name": "M. V. Narasimha Rao",
   "First": 1979,
   "Last": 1979,
   "Runs": "46",
   "HS": "20*"
 },
 {
   "Name": "Dhiraj Parsana",
   "First": 1979,
   "Last": 1979,
   "Runs": "1",
   "HS": "1"
 },
 {
   "Name": "Bharath Reddy",
   "First": 1979,
   "Last": 1979,
   "Runs": "38",
   "HS": "21"
 },
 {
   "Name": "Yashpal Sharma",
   "First": 1979,
   "Last": 1983,
   "Runs": "1606",
   "HS": "140"
 },
 {
   "Name": "Dilip Doshi",
   "First": 1979,
   "Last": 1983,
   "Runs": "129",
   "HS": "20"
 },
 {
   "Name": "Shivlal Yadav",
   "First": 1979,
   "Last": 1987,
   "Runs": "403",
   "HS": "43"
 },
 {
   "Name": "Roger Binny",
   "First": 1979,
   "Last": 1987,
   "Runs": "830",
   "HS": "83*"
 },
 {
   "Name": "Sandeep Patil",
   "First": 1980,
   "Last": 1984,
   "Runs": "1588",
   "HS": "174"
 },
 {
   "Name": "Kirti Azad",
   "First": 1981,
   "Last": 1983,
   "Runs": "135",
   "HS": "24"
 },
 {
   "Name": "Ravi Shastri",
   "First": 1981,
   "Last": 1992,
   "Runs": "3830",
   "HS": "206"
 },
 {
   "Name": "Yograj Singh",
   "First": 1981,
   "Last": 1981,
   "Runs": "10",
   "HS": "6"
 },
 {
   "Name": "T. E. Srinivasan",
   "First": 1981,
   "Last": 1981,
   "Runs": "48",
   "HS": "29"
 },
 {
   "Name": "Krishnamachari Srikkanth",
   "First": 1981,
   "Last": 1992,
   "Runs": "2062",
   "HS": "123"
 },
 {
   "Name": "Ashok Malhotra",
   "First": 1982,
   "Last": 1985,
   "Runs": "226",
   "HS": "72*"
 },
 {
   "Name": "Pranab Roy",
   "First": 1982,
   "Last": 1982,
   "Runs": "71",
   "HS": "60*"
 },
 {
   "Name": "Ghulam Parkar",
   "First": 1982,
   "Last": 1982,
   "Runs": "7",
   "HS": "6"
 },
 {
   "Name": "Suru Nayak",
   "First": 1982,
   "Last": 1982,
   "Runs": "19",
   "HS": "11"
 },
 {
   "Name": "Arun Lal",
   "First": 1982,
   "Last": 1989,
   "Runs": "729",
   "HS": "93"
 },
 {
   "Name": "Rakesh Shukla",
   "First": 1982,
   "Last": 1982,
   "Runs": "-",
   "HS": "-"
 },
 {
   "Name": "Maninder Singh",
   "First": 1982,
   "Last": 1993,
   "Runs": "99",
   "HS": "15"
 },
 {
   "Name": "Balwinder Sandhu",
   "First": 1983,
   "Last": 1983,
   "Runs": "214",
   "HS": "71"
 },
 {
   "Name": "T. A. Sekhar",
   "First": 1983,
   "Last": 1983,
   "Runs": "0",
   "HS": "0*"
 },
 {
   "Name": "Laxman Sivaramakrishnan",
   "First": 1983,
   "Last": 1986,
   "Runs": "130",
   "HS": "25"
 },
 {
   "Name": "Raghuram Bhat",
   "First": 1983,
   "Last": 1983,
   "Runs": "6",
   "HS": "6"
 },
 {
   "Name": "Navjot Singh Sidhu",
   "First": 1983,
   "Last": 1999,
   "Runs": "3202",
   "HS": "201"
 },
 {
   "Name": "Chetan Sharma",
   "First": 1984,
   "Last": 1989,
   "Runs": "396",
   "HS": "54"
 },
 {
   "Name": "Manoj Prabhakar",
   "First": 1984,
   "Last": 1995,
   "Runs": "1600",
   "HS": "120"
 },
 {
   "Name": "Mohammad Azharuddin",
   "First": 1985,
   "Last": 2000,
   "Runs": "6215",
   "HS": "199"
 },
 {
   "Name": "Gopal Sharma",
   "First": 1985,
   "Last": 1990,
   "Runs": "11",
   "HS": "10*"
 },
 {
   "Name": "Lalchand Rajput",
   "First": 1985,
   "Last": 1985,
   "Runs": "105",
   "HS": "61"
 },
 {
   "Name": "Sadanand Viswanath",
   "First": 1985,
   "Last": 1985,
   "Runs": "31",
   "HS": "20"
 },
 {
   "Name": "Kiran More",
   "First": 1986,
   "Last": 1993,
   "Runs": "1285",
   "HS": "73"
 },
 {
   "Name": "Chandrakant Pandit",
   "First": 1986,
   "Last": 1992,
   "Runs": "171",
   "HS": "39"
 },
 {
   "Name": "Raju Kulkarni",
   "First": 1986,
   "Last": 1987,
   "Runs": "2",
   "HS": "2"
 },
 {
   "Name": "Bharat Arun",
   "First": 1986,
   "Last": 1987,
   "Runs": "4",
   "HS": "2*"
 },
 {
   "Name": "Raman Lamba",
   "First": 1986,
   "Last": 1987,
   "Runs": "102",
   "HS": "53"
 },
 {
   "Name": "Arshad Ayub",
   "First": 1987,
   "Last": 1989,
   "Runs": "257",
   "HS": "57"
 },
 {
   "Name": "Sanjay Manjrekar",
   "First": 1987,
   "Last": 1996,
   "Runs": "2043",
   "HS": "218"
 },
 {
   "Name": "Narendra Hirwani",
   "First": 1988,
   "Last": 1996,
   "Runs": "54",
   "HS": "17"
 },
 {
   "Name": "Woorkeri Raman",
   "First": 1988,
   "Last": 1997,
   "Runs": "448",
   "HS": "96"
 },
 {
   "Name": "Ajay Sharma",
   "First": 1988,
   "Last": 1988,
   "Runs": "53",
   "HS": "30"
 },
 {
   "Name": "Rashid Patel",
   "First": 1988,
   "Last": 1988,
   "Runs": "0",
   "HS": "0"
 },
 {
   "Name": "Sanjeev Sharma",
   "First": 1988,
   "Last": 1990,
   "Runs": "56",
   "HS": "38"
 },
 {
   "Name": "M. Venkataramana",
   "First": 1989,
   "Last": 1989,
   "Runs": "0",
   "HS": "0*"
 },
 {
   "Name": "Salil Ankola",
   "First": 1989,
   "Last": 1989,
   "Runs": "6",
   "HS": "6"
 },
 {
   "Name": "Sachin Tendulkar",
   "First": 1989,
   "Last": 2013,
   "Runs": "15921",
   "HS": "248*"
 },
 {
   "Name": "Vivek Razdan",
   "First": 1989,
   "Last": 1989,
   "Runs": "6",
   "HS": "6*"
 },
 {
   "Name": "Venkatapathy Raju",
   "First": 1990,
   "Last": 2001,
   "Runs": "240",
   "HS": "31"
 },
 {
   "Name": "Atul Wassan",
   "First": 1990,
   "Last": 1990,
   "Runs": "94",
   "HS": "53"
 },
 {
   "Name": "Gursharan Singh",
   "First": 1990,
   "Last": 1990,
   "Runs": "18",
   "HS": "18"
 },
 {
   "Name": "Anil Kumble",
   "First": 1990,
   "Last": 2008,
   "Runs": "2506",
   "HS": "110*"
 },
 {
   "Name": "Javagal Srinath",
   "First": 1991,
   "Last": 2002,
   "Runs": "1009",
   "HS": "76"
 },
 {
   "Name": "Subroto Banerjee",
   "First": 1992,
   "Last": 1992,
   "Runs": "3",
   "HS": "3"
 },
 {
   "Name": "Pravin Amre",
   "First": 1992,
   "Last": 1993,
   "Runs": "425",
   "HS": "103"
 },
 {
   "Name": "Ajay Jadeja",
   "First": 1992,
   "Last": 2000,
   "Runs": "576",
   "HS": "96"
 },
 {
   "Name": "Rajesh Chauhan",
   "First": 1993,
   "Last": 1998,
   "Runs": "98",
   "HS": "23"
 },
 {
   "Name": "Vinod Kambli",
   "First": 1993,
   "Last": 1995,
   "Runs": "1084",
   "HS": "227"
 },
 {
   "Name": "Vijay Yadav",
   "First": 1993,
   "Last": 1993,
   "Runs": "30",
   "HS": "30"
 },
 {
   "Name": "Nayan Mongia",
   "First": 1994,
   "Last": 2001,
   "Runs": "1442",
   "HS": "152"
 },
 {
   "Name": "Aashish Kapoor",
   "First": 1994,
   "Last": 1996,
   "Runs": "97",
   "HS": "42"
 },
 {
   "Name": "Sunil Joshi",
   "First": 1996,
   "Last": 2000,
   "Runs": "352",
   "HS": "92"
 },
 {
   "Name": "Paras Mhambrey",
   "First": 1996,
   "Last": 1996,
   "Runs": "58",
   "HS": "28"
 },
 {
   "Name": "Venkatesh Prasad",
   "First": 1996,
   "Last": 2001,
   "Runs": "203",
   "HS": "30*"
 },
 {
   "Name": "Vikram Rathour",
   "First": 1996,
   "Last": 1997,
   "Runs": "131",
   "HS": "44"
 },
 {
   "Name": "Sourav Ganguly",
   "First": 1996,
   "Last": 2008,
   "Runs": "7212",
   "HS": "239"
 },
 {
   "Name": "Rahul Dravid",
   "First": 1996,
   "Last": 2012,
   "Runs": "13288",
   "HS": "270"
 },
 {
   "Name": "David Johnson",
   "First": 1996,
   "Last": 1996,
   "Runs": "8",
   "HS": "5"
 },
 {
   "Name": "V. V. S. Laxman",
   "First": 1996,
   "Last": 2012,
   "Runs": "8781",
   "HS": "281"
 },
 {
   "Name": "Dodda Ganesh",
   "First": 1997,
   "Last": 1997,
   "Runs": "25",
   "HS": "8"
 },
 {
   "Name": "Abey Kuruvilla",
   "First": 1997,
   "Last": 1997,
   "Runs": "66",
   "HS": "35*"
 },
 {
   "Name": "Nilesh Kulkarni",
   "First": 1997,
   "Last": 2001,
   "Runs": "5",
   "HS": "4"
 },
 {
   "Name": "Debashish Mohanty",
   "First": 1997,
   "Last": 1997,
   "Runs": "0",
   "HS": "0*"
 },
 {
   "Name": "Harbhajan Singh",
   "First": 1998,
   "Last": 2015,
   "Runs": "2224",
   "HS": "115"
 },
 {
   "Name": "Harvinder Singh",
   "First": 1998,
   "Last": 2001,
   "Runs": "6",
   "HS": "6"
 },
 {
   "Name": "Ajit Agarkar",
   "First": 1998,
   "Last": 2006,
   "Runs": "571",
   "HS": "109*"
 },
 {
   "Name": "Robin Singh",
   "First": 1998,
   "Last": 1998,
   "Runs": "27",
   "HS": "15"
 },
 {
   "Name": "Robin Singh, Jr.",
   "First": 1999,
   "Last": 1999,
   "Runs": "0",
   "HS": "0"
 },
 {
   "Name": "Sadagoppan Ramesh",
   "First": 1999,
   "Last": 2001,
   "Runs": "1367",
   "HS": "143"
 },
 {
   "Name": "Ashish Nehra",
   "First": 1999,
   "Last": 2004,
   "Runs": "77",
   "HS": "19"
 },
 {
   "Name": "Devang Gandhi",
   "First": 1999,
   "Last": 1999,
   "Runs": "204",
   "HS": "88"
 },
 {
   "Name": "MSK Prasad",
   "First": 1999,
   "Last": 2000,
   "Runs": "106",
   "HS": "19"
 },
 {
   "Name": "Vijay Bharadwaj",
   "First": 1999,
   "Last": 2000,
   "Runs": "28",
   "HS": "22"
 },
 {
   "Name": "Hrishikesh Kanitkar",
   "First": 1999,
   "Last": 2000,
   "Runs": "74",
   "HS": "45"
 },
 {
   "Name": "Wasim Jaffer",
   "First": 2000,
   "Last": 2008,
   "Runs": "1944",
   "HS": "212"
 },
 {
   "Name": "Murali Kartik",
   "First": 2000,
   "Last": 2004,
   "Runs": "88",
   "HS": "43"
 },
 {
   "Name": "Nikhil Chopra",
   "First": 2000,
   "Last": 2000,
   "Runs": "7",
   "HS": "4"
 },
 {
   "Name": "Mohammad Kaif",
   "First": 2000,
   "Last": 2006,
   "Runs": "624",
   "HS": "148*"
 },
 {
   "Name": "Shiv Sunder Das",
   "First": 2000,
   "Last": 2002,
   "Runs": "1326",
   "HS": "110"
 },
 {
   "Name": "Saba Karim",
   "First": 2000,
   "Last": 2000,
   "Runs": "15",
   "HS": "15"
 },
 {
   "Name": "Zaheer Khan",
   "First": 2000,
   "Last": 2014,
   "Runs": "1231",
   "HS": "75"
 },
 {
   "Name": "Vijay Dahiya",
   "First": 2000,
   "Last": 2000,
   "Runs": "2",
   "HS": "2*"
 },
 {
   "Name": "Sarandeep Singh",
   "First": 2000,
   "Last": 2002,
   "Runs": "43",
   "HS": "39*"
 },
 {
   "Name": "Rahul Sanghvi",
   "First": 2001,
   "Last": 2001,
   "Runs": "2",
   "HS": "2"
 },
 {
   "Name": "Sairaj Bahutule",
   "First": 2001,
   "Last": 2001,
   "Runs": "39",
   "HS": "21*"
 },
 {
   "Name": "Sameer Dighe",
   "First": 2001,
   "Last": 2001,
   "Runs": "141",
   "HS": "47"
 },
 {
   "Name": "Hemang Badani",
   "First": 2001,
   "Last": 2001,
   "Runs": "94",
   "HS": "38"
 },
 {
   "Name": "Deep Dasgupta",
   "First": 2001,
   "Last": 2002,
   "Runs": "344",
   "HS": "100"
 },
 {
   "Name": "Virender Sehwag",
   "First": 2001,
   "Last": 2013,
   "Runs": "8448",
   "HS": "319"
 },
 {
   "Name": "Sanjay Bangar",
   "First": 2001,
   "Last": 2002,
   "Runs": "470",
   "HS": "100*"
 },
 {
   "Name": "Iqbal Siddiqui",
   "First": 2001,
   "Last": 2001,
   "Runs": "29",
   "HS": "24"
 },
 {
   "Name": "Tinu Yohannan",
   "First": 2001,
   "Last": 2002,
   "Runs": "13",
   "HS": "8*"
 },
 {
   "Name": "Ajay Ratra",
   "First": 2002,
   "Last": 2002,
   "Runs": "163",
   "HS": "115*"
 },
 {
   "Name": "Parthiv Patel",
   "First": 2002,
   "Last": 2018,
   "Runs": "934",
   "HS": "71"
 },
 {
   "Name": "Lakshmipathy Balaji",
   "First": 2003,
   "Last": 2005,
   "Runs": "51",
   "HS": "31"
 },
 {
   "Name": "Aakash Chopra",
   "First": 2003,
   "Last": 2004,
   "Runs": "437",
   "HS": "60"
 },
 {
   "Name": "Yuvraj Singh",
   "First": 2003,
   "Last": 2012,
   "Runs": "1900",
   "HS": "169"
 },
 {
   "Name": "Irfan Pathan",
   "First": 2003,
   "Last": 2008,
   "Runs": "1105",
   "HS": "102"
 },
 {
   "Name": "Gautam Gambhir",
   "First": 2004,
   "Last": 2016,
   "Runs": "4154",
   "HS": "206"
 },
 {
   "Name": "Dinesh Karthik",
   "First": 2004,
   "Last": 2018,
   "Runs": "1025",
   "HS": "129"
 },
 {
   "Name": "MS Dhoni",
   "First": 2005,
   "Last": 2014,
   "Runs": "4876",
   "HS": "224"
 },
 {
   "Name": "R. P. Singh",
   "First": 2006,
   "Last": 2011,
   "Runs": "116",
   "HS": "30"
 },
 {
   "Name": "S. Sreesanth",
   "First": 2006,
   "Last": 2011,
   "Runs": "281",
   "HS": "35"
 },
 {
   "Name": "Piyush Chawla",
   "First": 2006,
   "Last": 2008,
   "Runs": "5",
   "HS": "4"
 },
 {
   "Name": "Munaf Patel",
   "First": 2006,
   "Last": 2011,
   "Runs": "60",
   "HS": "15*"
 },
 {
   "Name": "V. R. V. Singh",
   "First": 2006,
   "Last": 2007,
   "Runs": "47",
   "HS": "29"
 },
 {
   "Name": "Ramesh Powar",
   "First": 2007,
   "Last": 2007,
   "Runs": "13",
   "HS": "7"
 },
 {
   "Name": "Ishant Sharma",
   "First": 2007,
   "Last": 2020,
   "Runs": "720",
   "HS": "57"
 },
 {
   "Name": "Amit Mishra",
   "First": 2008,
   "Last": 2016,
   "Runs": "648",
   "HS": "84"
 },
 {
   "Name": "Murali Vijay",
   "First": 2008,
   "Last": 2018,
   "Runs": "3982",
   "HS": "167"
 },
 {
   "Name": "Pragyan Ojha",
   "First": 2009,
   "Last": 2013,
   "Runs": "89",
   "HS": "18*"
 },
 {
   "Name": "Subramaniam Badrinath",
   "First": 2010,
   "Last": 2010,
   "Runs": "63",
   "HS": "56"
 },
 {
   "Name": "Wriddhiman Saha",
   "First": 2010,
   "Last": 2019,
   "Runs": "1238",
   "HS": "117"
 },
 {
   "Name": "Abhimanyu Mithun",
   "First": 2010,
   "Last": 2011,
   "Runs": "120",
   "HS": "46"
 },
 {
   "Name": "Suresh Raina",
   "First": 2010,
   "Last": 2015,
   "Runs": "768",
   "HS": "120"
 },
 {
   "Name": "Cheteshwar Pujara",
   "First": 2010,
   "Last": 2020,
   "Runs": "5840",
   "HS": "206*"
 },
 {
   "Name": "Jaydev Unadkat",
   "First": 2010,
   "Last": 2010,
   "Runs": "2",
   "HS": "1*"
 },
 {
   "Name": "Praveen Kumar",
   "First": 2011,
   "Last": 2011,
   "Runs": "149",
   "HS": "40"
 },
 {
   "Name": "Virat Kohli",
   "First": 2011,
   "Last": 2020,
   "Runs": "7240",
   "HS": "254*"
 },
 {
   "Name": "Abhinav Mukund",
   "First": 2011,
   "Last": 2017,
   "Runs": "320",
   "HS": "81"
 },
 {
   "Name": "Ravichandran Ashwin",
   "First": 2011,
   "Last": 2020,
   "Runs": "2389",
   "HS": "124"
 },
 {
   "Name": "Umesh Yadav",
   "First": 2011,
   "Last": 2020,
   "Runs": "340",
   "HS": "31"
 },
 {
   "Name": "Varun Aaron",
   "First": 2011,
   "Last": 2015,
   "Runs": "35",
   "HS": "9"
 },
 {
   "Name": "Vinay Kumar",
   "First": 2012,
   "Last": 2012,
   "Runs": "11",
   "HS": "6"
 },
 {
   "Name": "Ravindra Jadeja",
   "First": 2012,
   "Last": 2020,
   "Runs": "1869",
   "HS": "100*"
 },
 {
   "Name": "Bhuvneshwar Kumar",
   "First": 2013,
   "Last": 2018,
   "Runs": "552",
   "HS": "63*"
 },
 {
   "Name": "Shikhar Dhawan",
   "First": 2013,
   "Last": 2018,
   "Runs": "2315",
   "HS": "190"
 },
 {
   "Name": "Ajinkya Rahane",
   "First": 2013,
   "Last": 2020,
   "Runs": "4203",
   "HS": "188"
 },
 {
   "Name": "Mohammed Shami",
   "First": 2013,
   "Last": 2020,
   "Runs": "497",
   "HS": "51*"
 },
 {
   "Name": "Rohit Sharma",
   "First": 2013,
   "Last": 2019,
   "Runs": "2141",
   "HS": "212"
 },
 {
   "Name": "Stuart Binny",
   "First": 2014,
   "Last": 2015,
   "Runs": "194",
   "HS": "78"
 },
 {
   "Name": "Pankaj Singh",
   "First": 2014,
   "Last": 2014,
   "Runs": "10",
   "HS": "9"
 },
 {
   "Name": "Karn Sharma",
   "First": 2014,
   "Last": 2014,
   "Runs": "8",
   "HS": "4*"
 },
 {
   "Name": "KL Rahul",
   "First": 2014,
   "Last": 2019,
   "Runs": "2006",
   "HS": "199"
 },
 {
   "Name": "Naman Ojha",
   "First": 2015,
   "Last": 2015,
   "Runs": "56",
   "HS": "35"
 },
 {
   "Name": "Jayant Yadav",
   "First": 2016,
   "Last": 2017,
   "Runs": "228",
   "HS": "104"
 },
 {
   "Name": "Karun Nair",
   "First": 2016,
   "Last": 2017,
   "Runs": "374",
   "HS": "303*"
 },
 {
   "Name": "Kuldeep Yadav",
   "First": 2017,
   "Last": 2019,
   "Runs": "51",
   "HS": "26"
 },
 {
   "Name": "Hardik Pandya",
   "First": 2017,
   "Last": 2018,
   "Runs": "532",
   "HS": "108"
 },
 {
   "Name": "Jasprit Bumrah",
   "First": 2018,
   "Last": 2020,
   "Runs": "32",
   "HS": "10*"
 },
 {
   "Name": "Rishabh Pant",
   "First": 2018,
   "Last": 2020,
   "Runs": "814",
   "HS": "159*"
 },
 {
   "Name": "Hanuma Vihari",
   "First": 2018,
   "Last": 2020,
   "Runs": "552",
   "HS": "111"
 },
 {
   "Name": "Prithvi Shaw",
   "First": 2018,
   "Last": 2020,
   "Runs": "335",
   "HS": "134"
 },
 {
   "Name": "Shardul Thakur",
   "First": 2018,
   "Last": 2018,
   "Runs": "4",
   "HS": "4*"
 },
 {
   "Name": "Mayank Agarwal",
   "First": 2018,
   "Last": 2020,
   "Runs": "974",
   "HS": "243"
 },
 {
   "Name": "Shahbaz Nadeem",
   "First": 2019,
   "Last": 2019,
   "Runs": "1",
   "HS": "1*"
 }
]""";