import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/create_partner_account_controller.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';

class ManagePartnerUser extends StatefulWidget {
  const ManagePartnerUser({Key? key}) : super(key: key);

  @override
  State<ManagePartnerUser> createState() => _ManagePartnerUserState();
}

class _ManagePartnerUserState extends State<ManagePartnerUser> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "𝑯𝑨𝑳𝑶 𝑭𝒂𝒔𝒉𝒊𝒐𝒏 𝑺𝒕𝒂𝒓",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: appBarTitleColor,
              wordSpacing: 1),
        ),
        elevation: 0,
        backgroundColor: detailBackgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: appBarTitleColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: OutlinedButton(
              onPressed: () {
                Get.put(CreatePartnerAccountController());
                Get.defaultDialog(
                  contentPadding: EdgeInsets.all(20),
                  title: "Create Partner Account",
                  content: InputFormWidget(),
                );
              },
              child: Text("Add partner user",
              style: TextStyle(
                color: Colors.indigo
              ),),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        child: Obx(() {
          if (controller.isPageLoading.value == false) {
            if (controller.authUserList.isNotEmpty) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: controller.authUserList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.authUserList[index].uid),
                    subtitle:
                        Text(controller.authUserList[index].email ?? "error"),
                  );
                },
              );
            } else {
              return Center(child: Text("No partner user yet!"));
            }
          } else {
            return Center(
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()));
          }
        }),
        onRefresh: () => controller.getAuthUsers(),
      ),
    );
  }
}

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CreatePartnerAccountController controller = Get.find();
    return Center(
      child: SizedBox(
        height: 150,
        width: 300,
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 100,
              child: ListView(
                children: [
                  //Email Textfield
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: "Enter email address",
                    ),
                    validator: controller.validator,
                  ),
                  //Password TextField
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                    ),
                    validator: controller.validator,
                  ),
                  //Create Button
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: controller.createPartnerAccount,
                      child: Obx(
                        () => controller.isUploading.value
                            ? CircularProgressIndicator(
                                color: scaffoldBackground,
                              )
                            : Text("Create",
                        style: TextStyle(
                          color: Colors.black
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
