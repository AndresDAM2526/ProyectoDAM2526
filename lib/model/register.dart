class Register {
  String product;
  String user;
  String name;
  String typeRegiser;
  String type;
  String location;
  String date;
  int quantity;
  String? duration;
  String? description;

  Register({
    required this.user,
    required this.name,
    required this.product,
    required this.typeRegiser,
    required this.type,
    required this.location,
    required this.date,
    required this.quantity,
    required this.duration,
    required this.description,
  });
}
