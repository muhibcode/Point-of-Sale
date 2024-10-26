import 'package:client/pages/Invoice/all_invoices.dart';
import 'package:client/pages/qout/add_qout.dart';
import 'package:client/pages/qout/all_qouts.dart';
import 'package:client/pages/qout/view_quot.dart';
import 'package:client/pages/account/login.dart';
import 'package:client/pages/account/register.dart';
import 'package:client/pages/customer/add_client.dart';
import 'package:client/pages/customer/all_client.dart';
import 'package:client/pages/customer/edit_client.dart';
import 'package:client/pages/operations/add_vendor.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final Object? arguments = settings.arguments;
  print(arguments);
  switch (settings.name) {
    case AddClientR:
      return getPageRoute(const AddClient());
    case AllClientsR:
      return getPageRoute(AllClients());
    case EditClientR:
      return getPageRoute(EditClient(val: {'id': arguments}));
    // case PdfR:
    //   return getPageRoute(InvoicePdf());
    case AllQuotsR:
      return getPageRoute(AllQuots());
    case AddQuotR:
      return getPageRoute(AddQuot(vals: {'id': arguments}));
    case ViewQuotR:
      return getPageRoute(ViewQuot());
    case SaleOrdersR:
      return getPageRoute(AllQuots());
    case PurchaseOrdersR:
      return getPageRoute(AddQuot());
    case AllInvoicesR:
      return getPageRoute(const AllInvoices());
    case AllPaymentsR:
      return getPageRoute(const AllInvoices());
    case UserLoginR:
      return getPageRoute(Login());
    case RegisterR:
      return getPageRoute(SignUp());
    default:
      return getPageRoute(AddOrders());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
