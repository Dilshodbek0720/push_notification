class ChatModel{
  String name;
  String massage;
  String productId;
  String createdAt;

  ChatModel({
    required this.name,
    required this.massage,
    required this.productId,
    required this.createdAt
  });

  factory ChatModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatModel(
      name: jsonData['name'] as String? ?? '',
      productId: jsonData['productId'] as String? ?? '',
      massage: jsonData['massage'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productId': productId,
      'massage': massage,
      'createdAt': createdAt
    };
  }
}