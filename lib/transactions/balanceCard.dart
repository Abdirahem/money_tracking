import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../ourcovertor.dart';

class BalanceCard extends StatefulWidget {
  final String totalIncome, totalBalance, totalExpense;
  BalanceCard(
      {required this.totalIncome,
      required this.totalBalance,
      required this.totalExpense});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  final formatCurrency = new NumberFormat.simpleCurrency();
  final convertLacag = CurrencyFormatting();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('B A L A N C E',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.sp)),
            Text(
              '${formatCurrency.format(int.parse(widget.totalBalance)).toString()}',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Income',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '${formatCurrency.format(int.parse(widget.totalIncome)).toString()}',
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: Colors.white,
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expense',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${formatCurrency.format(int.parse(widget.totalExpense)).toString()}',
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Color(0xff27AAC4).withOpacity(0.3), BlendMode.dstATop),
              image: ExactAssetImage("imgs/card bg.jpg"),
              fit: BoxFit.cover),
          color: Color(0xff27AAC4)),
    );
  }
}
