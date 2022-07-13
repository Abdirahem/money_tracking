import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tixraac/transactions/transaction.dart';

// ignore: must_be_immutable
class AddTransaction extends StatefulWidget {
  String uid, user_name;
  AddTransaction({required this.uid, required this.user_name});
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  bool isIncome = false;
  String? transactionType;

  TextEditingController transactionTitle = TextEditingController();
  TextEditingController transactionValue = TextEditingController();
  String phpurl = "http://192.168.1.20/tixraac/insertTransaction.php";

  bool? error, sending, success;
  String? msg;

  @override
  void initState() {
    ;
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  insertTransaction() async {
    http.Response response = await http.post(Uri.parse(phpurl), body: {
      "transactionType": transactionType.toString(),
      "transactionTitle": transactionTitle.text,
      "transactionValue": transactionValue.text,
      "user_id": widget.uid,
    });

    if (response.statusCode == 200) {
      var xog = json.decode(response.body);
      print(response.body);
      if (xog["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = xog["message"]; //error message from server
        });
      } else {
        transactionTitle.clear();
        transactionValue.clear();

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(" before switch: ${isIncome}");
    return Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // transaction type
          Text("T R A N S A C T I O N",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              )),
          // row for transacntion type swtich
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Expense"),
              Switch(
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red.shade200,
                  inactiveThumbColor: Colors.red,
                  value: isIncome,
                  onChanged: (value) {
                    setState(() {
                      isIncome = value;
                      print(isIncome);
                    });
                  }),
              Text("Income"),
            ],
          ),
          Text(
            isIncome ? transactionType = "income" : transactionType = "expense",
          ),
          SizedBox(height: 10.h),
          // textfield for transaction title
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: transactionTitle,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.h),
                  hintText: "Transaction Title",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade200),
            ),
          ),
          SizedBox(height: 15.h),
          // textfield for transaction money value
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: transactionValue,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.h),
                  hintText: "Transaction value",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade200),
            ),
          ),
          SizedBox(height: 15.h),
          // button for adding
          GestureDetector(
            onTap: () {
              if (transactionTitle.text.isEmpty ||
                  transactionValue.text.isEmpty) {
                print("Please fill the fields");
              } else {
                setState(() {
                  insertTransaction();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Transaction(
                                user_id: widget.uid.toString(),
                                uname: widget.user_name,
                              )));
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(15.h),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff27AAC4),
                  borderRadius: BorderRadius.circular(3)),
              child: Text("add",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
