import 'package:cached_network_image/cached_network_image.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/data/enum.dart';
import 'package:kozarni_ecome/data/township_list.dart';
import 'package:kozarni_ecome/model/division.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:kozarni_ecome/widgets/custom_checkbox.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HomeController controller = Get.find();
    controller.updateSubTotal(false); //Make Sure To Update SubTotal

    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.myCart.length,
              itemBuilder: (_, i) {
                String photo = "";
                if (controller.myCart[i].isOwnBrand) {
                  photo =
                      controller.getBrandItem(controller.myCart[i].id).photo;
                } else {
                  photo = controller.getItem(controller.myCart[i].id).photo;
                }
                return Card(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: photo,
                          // "$baseUrl$itemUrl${controller.getItem(controller.myCart[i].id).photo}/get",
                          width: 100,
                          height: 130,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                controller
                                    .getItem(controller.myCart[i].id)
                                    .name,
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                            SizedBox(height: 5),
                            Text(
                              "${controller.myCart[i].color}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${controller.myCart[i].size}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${controller.myCart[i].showcaseMap["text"]} \n ${controller.myCart[i].showcaseMap["price"]} ????????????",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.remove(controller.myCart[i]);
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(controller.myCart[i].count.toString()),
                            IconButton(
                              onPressed: () {
                                controller.addCount(controller.myCart[i]);
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        GetBuilder<HomeController>(builder: (controller) {
          return Container(
            width: double.infinity,
            height: 250,
            child: Card(
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Usual Product
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "????????????????????????????????????????????????????????????????????? ???????????????????????????   "
                            "${controller.totalUsualProductCount} ?????? ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            //Change Variable
                            "${(controller.totalUsualPrice).round()} ????????????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Hot Special Product
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "???????????????????????????????????????????????????????????? ???????????????????????????   "
                            "${controller.totalHotProductCount} ??????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${controller.totalHotPrice} ????????????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "???????????????????????????????????????????????? ???????????????????????????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${controller.subTotal} ????????????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //DropDown TownShip List
                          Container(
                            width: 150,
                            height: 50,
                            child: GetBuilder<HomeController>(
                                builder: (controller) {
                              return InkWell(
                                onTap: () {
                                  //Show Dialog
                                  Get.dialog(
                                    divisionDialogWidget(),
                                    barrierDismissible: true,
                                    barrierColor: Colors.black.withOpacity(0),
                                      );
                                },
                                child: Row(children: [
                                  //Township Name
                                  Expanded(
                                    child: Text(
                                      controller
                                              .townShipNameAndFee["townName"] ??
                                          "????????????????????????",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  //DropDown Icon
                                  Expanded(
                                      child: Icon(FontAwesomeIcons.angleDown)),
                                ]),
                              );
                            }),
                          ),

                          Text(
                            "??????????????????????????????????????????",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          GetBuilder<HomeController>(builder: (controller) {
                            return Text(
                              controller.townShipNameAndFee.isEmpty
                                  ? "0 ????????????"
                                  : " ${controller.townShipNameAndFee["fee"]} ????????????",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(25, 25, 25, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "?????????????????????????????? ???????????????????????????   =  ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GetBuilder<HomeController>(builder: (controller) {
                            return Text(
                              controller.townShipNameAndFee.isEmpty
                                  ? "${controller.subTotal}"
                                  : "${controller.subTotal + controller.townShipNameAndFee["fee"]} ????????????",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        Container(
          width: double.infinity,
          height: 45,
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colours.gold),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              if (controller.myCart.isNotEmpty &&
                  !(controller.townShipNameAndFee.isEmpty)) {
                //TODO: SHOW DIALOG TO CHOOSE OPTION,THEN GO TO CHECKOUT
                Get.defaultDialog(
                  backgroundColor: Colors.white70,
                  titlePadding: EdgeInsets.all(8),
                  contentPadding: EdgeInsets.all(0),
                  title: "Choose Options",
                  content: PaymentOptionContent(),
                  barrierDismissible: false,
                  confirm: nextButton(),
                );
                //Get.toNamed(checkOutScreen);
              } else {
                Get.snackbar('Error', "Cart is empty");
              }
            },
            child: Text(
              "Order ?????????????????? ?????????????????????",
              style: TextStyle(color: Colours.black),
            ),
          ),
        )
      ],
    );
  }

  Widget divisionDialogWidget() {
    return  Scaffold(
      backgroundColor: Colors.black.withOpacity(0),
      body: Align(
          alignment: Alignment.center,
          child: GetBuilder<HomeController>(builder: (controller) {
            return Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border(),
              ),
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: divisionList.length,
                itemBuilder: (context, divisionIndex) {
                  return InkWell(
                    onTap: () {
                      debugPrint("**********MouseEnter: ..");
                      controller.changeMouseIndex(divisionIndex);
                      showDialog(
                        context: context,
                        barrierColor: Colors.white.withOpacity(0),
                        builder: (context) {
                          return townShipDialog(
                              division: divisionList[divisionIndex]);
                        },
                      );
                    },
                    /*onExit: (event) {
                      // controller
                      //   .changeMouseIndex(0);
                      Navigator.of(context).pop();
                    },*/
                    child: AnimatedContainer(
                      color: controller.mouseIndex == divisionIndex
                          ? Colors.orange
                          : Colors.white,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Text
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Text(divisionList[divisionIndex].name),
                            ),
                            SizedBox(width: 10),
                            Icon(FontAwesomeIcons.angleUp),
                          ]),
                    ),
                  );
                },
              ),
            );
          }),
      
      ),
    );
  }

  Widget townShipDialog({required Division division}) {
    HomeController _controller = Get.find();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        height: MediaQuery.of(Get.context!).size.height,
        decoration: BoxDecoration(
          border: Border(),
          color: Colors.white,
        ),
        child: ListView(
          children: division.townShipMap.entries.map((map) {
            return SizedBox(
              height: map.value.length * 50,
              child: ListView.builder(
                  primary: false,
                  itemCount: map.value.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        _controller.setTownShipNameAndShip(
                          name: map.value[index],
                          fee: map.key,
                        );
                        //Pop this dialog
                        Get.back();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(map.value[index],
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    );
                  }),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PaymentOptionContent extends StatelessWidget {
  const PaymentOptionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomCheckBox(
          height: 50,
          options: PaymentOptions.CashOnDelivery,
          icon: FontAwesomeIcons.truck,
          iconColor: Colors.amber,
          text: "??????????????????????????? ???????????????????????????",
        ),
        SizedBox(height: 5),
        CustomCheckBox(
          height: 50,
          options: PaymentOptions.PrePay,
          icon: FontAwesomeIcons.moneyBill,
          iconColor: Colors.blue,
          text: "?????????????????????????????????????????????????????????",
        ),
      ]),
    );
  }
}

Widget nextButton() {
  HomeController controller = Get.find();
  return //Next
      Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colours.gold,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: TextButton(
      onPressed: () {
        if (controller.paymentOptions != PaymentOptions.None) {
          //Go To CheckOut Screen
          Navigator.of(Get.context!).pop();
          Get.toNamed(checkOutScreen);
        }
      },
      child: Text("Next    ???", style: TextStyle(color: Colors.black)),
    ),
  );
}
