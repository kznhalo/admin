import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/model/order_revenue.dart';
import 'package:kozarni_ecome/utils/utils.dart';

import '../data/constant.dart';

class OrderRevenueScreen extends StatefulWidget {
  const OrderRevenueScreen({Key? key}) : super(key: key);

  @override
  State<OrderRevenueScreen> createState() => _OrderRevenueScreenState();
}

class _OrderRevenueScreenState extends State<OrderRevenueScreen> {
  late Future<OrderRevenue> orderRevenue;
  HomeController controller = Get.find();
  @override
  void initState() {
    orderRevenue = controller.getOrderRevenue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: detailTextBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "HALO Fashion Star Order & Revenue",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
          ),
        ),
      ),
      body: FutureBuilder<OrderRevenue>(
        future: orderRevenue,
        builder: (context, snap) {
          if (snap.hasData) {
            final orderRe = snap.data;
            if (!(orderRe == null)) {
              return SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Total Order Count
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: homeIndicatorColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Order",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${orderRe.totalOrder}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Space
                      const SizedBox(width: 50),
                      //Total Revenue
                      Container(
                          height: 100,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Revenue",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                getCurrency(orderRe.totalRevenue),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ));
            }
          } else if (snap.hasError) {
            return ErrorWidget("Error: ${snap.error}");
          }
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
