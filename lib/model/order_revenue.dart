class OrderRevenue {
  final int totalOrder;
  final int totalRevenue;
  OrderRevenue({required this.totalOrder, required this.totalRevenue});

  factory OrderRevenue.fromJson(Map<String, dynamic> json) => OrderRevenue(
        totalOrder: json["totalOrder"] as int,
        totalRevenue: json["totalRevenue"] as int,
      );

  Map<String, dynamic> toJson() => {
        "totalOrder": totalOrder,
        "totalRevenue": totalRevenue,
      };
}
