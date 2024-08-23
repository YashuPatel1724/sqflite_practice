import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../helper/db_helper.dart';

class DbController extends GetxController
{
  RxList data = [].obs;
  var txtAmount = TextEditingController();
  var txtCat = TextEditingController();
  RxDouble totalIncome =0.0.obs;
  RxDouble totalExpence =0.0.obs;
  RxBool isIncome = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initDb();
  }

  void setIncome(bool value)
  {
    isIncome.value = value;
  }

  Future initDb()
  async {
    await DbHelper.dbHelper.database;
    readRecords();
  }

  Future insertRecord(double amount,int isIncome,String category)
  async {
    await DbHelper.dbHelper.insertData(amount,isIncome,category);
    readRecords();
  }

  Future readRecords()
  async {
    totalIncome.value = 0.0;
    totalExpence.value = 0.0;
    data.value = await DbHelper.dbHelper.readData();
    for(var i in data)
      {
        if(i['isIncome'] == 1)
          {
            totalIncome.value = totalIncome.value + i['amount'];
          }
        else
          {
            totalExpence.value = totalExpence.value + i['amount'];
          }
      }
    return data;
  }

  Future<void> updateRecord(double amount, int isIncome, String category,int id)
  async {
    await DbHelper.dbHelper.updateData(amount, isIncome, category,id);
    await readRecords();
  }
  Future<void> removeRecord(int id)
  async {
    await DbHelper.dbHelper.removeData(id);
    readRecords();
  }
}