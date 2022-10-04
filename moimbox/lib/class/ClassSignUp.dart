
class ClassSignUp{
  final String title;
  late String tag;
  final String? imageUrl;
  final String? location;
  final String? numberOfPeople;
  final String? frequency;
  final String? price;

  ClassSignUp({
    required this.title,
    required this.tag,
    this.imageUrl,
    this.location,
    this.numberOfPeople,
    this.frequency,
    this.price
  });
}
