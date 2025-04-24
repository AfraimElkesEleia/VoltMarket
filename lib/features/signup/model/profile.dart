class Profile {
  final String uuid;
  final String name;
  final String? email;
  final String? address;
  final String? city;
  final String? zip;
  final String imgProfile;

  Profile({
    required this.uuid,
    required this.name,
    this.email,
    this.address,
    this.city,
    this.zip,
    required this.imgProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': uuid,
      'full_name': name,
      'email': email,
      'address': address,
      'city': city,
      'zip': zip,
      'img_profile': imgProfile,
    };
  }

  factory Profile.fromJson(json) {
    return Profile(
      uuid: json['id'],
      name: json['full_name'],
      email: json['email'],
      city: json['city'],
      address: json['address'],
      zip: json['zip'],
      imgProfile: json['img_profile'],
    );
  }
}
