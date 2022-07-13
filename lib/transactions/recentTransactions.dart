import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RecentTransactions extends StatefulWidget {
  final String TransactionName;
  final String TransactionValue;

  final String ExpenseOrIncome;
  RecentTransactions(
      {required this.TransactionName,
      required this.ExpenseOrIncome,
      required this.TransactionValue});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  final formatCurrency = new NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.grey.shade300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: widget.ExpenseOrIncome == "income"
                          ? Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      (widget.ExpenseOrIncome == 'expense' ? '-' : '+') +
                          // widget.TransactionValue,
                          formatCurrency
                              .format(int.parse(widget.TransactionValue))
                              .toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.ExpenseOrIncome == "expense"
                            ? Colors.red
                            : Colors.green,
                      )),
                ],
              ),
              Text(
                widget.TransactionName,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
