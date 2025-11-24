class LostItem {
  final String id;
  final String name;
  final String description;
  final String location;
  final String imageUrl;

  LostItem({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'location': location,
        'imageUrl': imageUrl,
      };
}
