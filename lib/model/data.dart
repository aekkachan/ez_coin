class Data {
  List<dynamic>? prices;
  List<dynamic>? marketCaps;
  List<dynamic>? totalVolumes;

  Data({this.prices, this.marketCaps, this.totalVolumes});

  Data.fromJson(Map<String, dynamic> json) {

    if (json['prices'] != null) {
      prices = <dynamic>[];
      json['prices'].forEach((v) { prices!.add(v); });
    }
    if (json['market_caps'] != null) {
      marketCaps = <List>[];
      json['market_caps'].forEach((v) { marketCaps!.add(v); });
    }
    if (json['total_volumes'] != null) {
      totalVolumes = <List>[];
      json['total_volumes'].forEach((v) { totalVolumes!.add(v); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prices != null) {
      data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    }
    if (this.marketCaps != null) {
      data['market_caps'] = this.marketCaps!.map((v) => v.toJson()).toList();
    }
    if (this.totalVolumes != null) {
      data['total_volumes'] = this.totalVolumes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}