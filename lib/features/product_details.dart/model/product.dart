import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;

  @JsonKey(name: 'image')
  final String imageUrl;

  final Map<String, double> rating;

  Product(this.id, this.title, this.price, this.description, this.category,
      this.imageUrl, this.rating);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
