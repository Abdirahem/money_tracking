// ignore_for_file: unused_import, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixraac/appscreens/profile.dart';
import 'package:tixraac/transactions/addTransaction.dart';
import 'package:tixraac/transactions/balanceCard.dart';
import 'package:tixraac/transactions/recentTransactions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  String user_id, uname;
  Transaction({required this.user_id, required this.uname});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  final formatCurrency = new NumberFormat.simpleCurrency();

  var total_income = 0;
  var total_expense = 0;
  var total_balance = 0;

  bool isIcome = true;

  Map mapResponse = {};
  List reponseList = [];

  String phpurl = "http://192.168.1.20/tixraac/transaction_api.php";

  getTransactions() async {
    http.Response response = await http.post(Uri.parse(phpurl), body: {
      "user_id": widget.user_id,
    });
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        reponseList = mapResponse["transactions"];
        // print(reponseList[0]['type']);
        for (var i = 0; i < reponseList.length; i++) {
          var type = reponseList[i]["type"];
          if (type == "expense") {
            total_expense += int.parse(reponseList[i]["tvalue"]);
            print("Total Expense: ${total_expense}");
          } else {
            total_income += int.parse(reponseList[i]["tvalue"]);
            print("Income: ${reponseList[i]["tvalue"]}");
          }
          // total balnce

          setState(() {
            total_balance = total_income - total_expense;
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getTransactions();
    });
  }

  @override
  void initState() {
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerscaffoldkey,
      drawer: Drawer(
        child: Profile(
          getId: widget.user_id,
          getName: widget.uname,
        ),
      ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff27AAC4),
          leading: IconButton(
              onPressed: () {
                if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                  //if drawer is open, then close the drawer
                  Navigator.pop(context);
                } else {
                  _drawerscaffoldkey.currentState!.openDrawer();
                  //if drawer is closed then open the drawer.
                }
              },
              icon: Icon(
                FontAwesomeIcons.bars,
              ))),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance Card
                BalanceCard(
                  totalIncome: total_income.toString(),
                  totalExpense: total_expense.toString(),
                  totalBalance: total_balance.toString(),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Transactions",
                  style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700),
                ),
                SizedBox(height: 15.h),

                // list
                Container(
                  height: 320.h,
                  child: ListView.builder(
                      itemCount: reponseList.length,
                      itemBuilder: (BuildContext, index) {
                        return RecentTransactions(
                          TransactionName: reponseList[index]["title"],
                          ExpenseOrIncome: reponseList[index]["type"],
                          TransactionValue:
                              reponseList[index]["tvalue"].toString(),
                        );
                      }),
                ),
                SizedBox(height: 10.h),
                // Button
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff27AAC4),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    content: AddTransaction(
                                      uid: widget.user_id.toString(),
                                      user_name: widget.uname,
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.add,
                            size: 30.h,
                            color: Colors.white,
                          ),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
