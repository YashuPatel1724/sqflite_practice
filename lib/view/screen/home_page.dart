import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_practice/controller/db_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DbController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Obx(() => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Total Income',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            '${controller.totalIncome.value}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Total Expence',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            '${controller.totalExpence.value}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    color: controller.data[index]['isIncome'] == 1
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    child: ListTile(
                      leading: Text('${controller.data[index]['id']}'),
                      title: Text('${controller.data[index]['amount']}'),
                      subtitle: Text('${controller.data[index]['category']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Update Details'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: controller.txtAmount,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Amount'),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: controller.txtCat,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Category'),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Obx(
                                          () => SwitchListTile(
                                            title: Text('Income/Expance'),
                                            value: controller.isIncome.value,
                                            onChanged: (value) {
                                              controller.setIncome(value);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            controller.updateRecord(
                                                double.parse(
                                                    controller.txtAmount.text),
                                                controller.isIncome.value
                                                    ? 1
                                                    : 0,
                                                controller.txtCat.text,
                                                controller.data[index]['id']);
                                            Get.back();
                                            controller.txtAmount.clear();
                                            controller.txtCat.clear();
                                            controller.isIncome.value = false;
                                          },
                                          child: Text('Save')),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit)), // edit
                          InkWell(
                              onTap: () {
                                controller
                                    .removeRecord(controller.data[index]['id']);
                              },
                              child: Icon(Icons.delete)), // delete
                        ],
                      ),
                    ),
                  ),
                  itemCount: controller.data.length,
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Budget'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtAmount,
                    decoration: InputDecoration(hintText: 'Enter Amount'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.txtCat,
                    decoration: InputDecoration(hintText: 'Enter Category'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => SwitchListTile(
                      title: Text('Income/Expance'),
                      value: controller.isIncome.value,
                      onChanged: (value) {
                        controller.setIncome(value);
                      },
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      double amount = double.parse(controller.txtAmount.text);
                      int isIncome = controller.isIncome.value ? 1 : 0;
                      String category = controller.txtCat.text;
                      controller.insertRecord(amount, isIncome, category);

                      controller.txtAmount.clear();
                      controller.txtCat.clear();
                      controller.setIncome(false);
                      Get.back();
                    },
                    child: Text('Save')),
              ],
            ),
          );
        },// add data
        child: Icon(Icons.add),
      ),
    );
  }
}
