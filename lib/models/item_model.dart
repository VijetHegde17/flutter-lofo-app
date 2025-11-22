enum ItemType { lost, found }

extension ItemTypeX on ItemType {
  String get label => this == ItemType.lost ? 'Lost' : 'Found';
  String get collectionName =>
      this == ItemType.lost ? 'lost_items' : 'found_items';

  static ItemType fromString(String value) {
    return value.toLowerCase() == 'found' ? ItemType.found : ItemType.lost;
  }
}

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.contact,
    required this.type,
    required this.imageUrl,
    required this.createdAt,
    required this.userId,
  });

  final String id;
  final String title;
  final String description;
  final String location;
  final String contact;
  final ItemType type;
  final String? imageUrl;
  final DateTime createdAt;
  final String userId;

  ItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? contact,
    ItemType? type,
    String? imageUrl,
    DateTime? createdAt,
    String? userId,
  }) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      contact: contact ?? this.contact,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  // From Supabase JSON
  factory ItemModel.fromJson(
    Map<String, dynamic> json,
    ItemType type,
  ) {
    return ItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
      type: type,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      userId: json['user_id'] as String? ?? '',
    );
  }

  // To Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'contact': contact,
      'type': type.label.toLowerCase(),
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }
}


