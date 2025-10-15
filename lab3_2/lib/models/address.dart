class Address {
  final String recipientName;
  final String phoneNumber;
  final String province;
  final String district;
  final String ward;
  final String details;
  final double? latitude;
  final double? longitude;

  Address({
    required this.recipientName,
    required this.phoneNumber,
    required this.province,
    required this.district,
    required this.ward,
    required this.details,
    this.latitude,
    this.longitude,
  });
}
