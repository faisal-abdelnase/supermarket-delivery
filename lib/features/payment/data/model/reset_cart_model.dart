class ResetCartModel {
  int totalItem;
  double subTotal;
  double vat;
  double shippingFee;
  double totalPayable;

  ResetCartModel(
    {required this.totalItem, 
    required this.subTotal, 
    required this.vat, 
    required this.shippingFee, 
    required this.totalPayable});
}