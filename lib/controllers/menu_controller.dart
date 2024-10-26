import 'package:client/API.dart';
import 'package:client/routing/routes.dart';
import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenusController extends GetxController {
  static MenusController instance = Get.find();

  var activeItem = AllClientsR.obs;
  var activeChildItem = "".obs;
  var mydata = [].obs;
  var hoverItem = "".obs;
  var currency = ''.obs;
  var active = ''.obs;
  var language = ''.obs;
  var industry = ''.obs;
  var pterms = ''.obs;
  var qty = 0;
  var price = 0;
  var subtotal = 0.obs;
  var sub = [];
  var data = {};
  var ndata = [].obs;
  var sumCount = 0;
  var curSign = '\$'.obs;
  var resdata = {}.obs;
  var idVal = ''.obs;
  List<Map<String, dynamic>> newData = [];

  var selected = "a".obs;
  RxInt rollno = 0.obs;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  newArr() async {
    var res = await getReq('clients');
    var json = res.data;

    if (json['message'] == 'success') {
      mydata.value = json['clients'];
      // ndata.value = json['clients'];
      for (var e in mydata) {
        newData.add(e);
      }
    }
  }

  findClient(id) async {
    var res = await getReq('clients/$id');
    var json = res.data;
    if (json['message'] == 'success') {
      resdata.value = json['client'];
      return resdata;
    }
  }

  delClient(id) async {
    // final url = Uri.parse('http://localhost:8000/api/clients/$id');
    await delData('clients/$id');
    // var json = jsonDecode(res.body);
    ndata.isNotEmpty
        ? ndata.removeWhere((item) => item['id'] == id)
        : mydata.removeWhere((item) => item['id'] == id);

    // if (json['message'] == 'success') {
    //   // print(resdata);
    // }
  }

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  changeActiveChildItem(String itemName) {
    activeChildItem.value = itemName;
  }

  onHoverItem(String itemName) {
    if (!isActive(itemName) && !isChildActive(itemName)) {
      hoverItem.value = itemName;
    }
  }

  incIndex(val) {
    selected.value = val;
  }

  decIndex() {
    selected.value = "a";
  }

  bool isActive(String itemName) => activeItem.value == itemName;
  bool isChildActive(String itemName) => activeChildItem.value == itemName;

  bool isHoveinrg(String itemName) => hoverItem.value == itemName;

  Icon returnIconfor(String itemName) {
    switch (itemName) {
      case AllClientsR:
        return customIcon(Icons.people, itemName);
      case AddOrderR:
        return customIcon(Icons.category, itemName);
      case AllQuotsR:
        return customIcon(Icons.request_quote, itemName);
      case RevenueR:
        return customIcon(Icons.bar_chart, itemName);
      case RegisterR:
        return customIcon(Icons.app_registration, itemName);
      case UserLoginR:
        return customIcon(Icons.login, itemName);
      default:
        return customIcon(Icons.home, itemName);
    }
  }

  setActive(val) {
    active.value = val;
  }

  setCurCode(itemName) {
    switch (itemName) {
      case 'Pound Sterling':
        return curSign.value = cSymbol('GBP');
      case 'US Dollar':
        return curSign.value = cSymbol('USD');
      default:
        curSign.value = cSymbol('GBP');
    }
  }

  setDropDown(itemName, String value) {
    switch (itemName) {
      case 'Active':
        return active.value = value == 'Yes' ? '1' : '0';
      case 'Industry':
        return industry.value = value;
      case 'Language':
        return language.value = value;
      case 'Default Currency':
        return currency.value = value;
      case 'Payment Terms':
        return pterms.value = value;

      default:
        return '';
    }
  }

  Icon customIcon(IconData icon, String itemName) {
    if (isActive(itemName) || isChildActive(itemName)) {
      return Icon(
        icon,
        color: Colors.black,
      );
    }

    // if (isActive(itemName)) {
    //   return Icon(
    //     icon,
    //     color: Colors.black,
    //   );
    // }

    return Icon(
      icon,
      color: isHoveinrg(itemName) ? Colors.black : Colors.grey[700],
    );
  }
}
