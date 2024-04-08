class Event {
  String name;
  String description;
  String type; // Changed Bool to bool
  String price;
  String endPrice; // Consider using int or double instead of String
  String quota;
  String city;
  String address;
  DateTime date; // Changed DatePickerDialog to DateTime
  Event({
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.quota,
    required this.city,
    required this.address,
    required this.endPrice,
    required this.date, // Added required modifier for date
  });
}
