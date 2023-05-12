class AppUser{
  final String name;
  final String email;
  final String phone;
  final int role;
  final String address;


  AppUser({required this.name,required this.email,required this.phone,required this.role,required this.address});

  factory AppUser.fromJson(Map<String,dynamic> json) {
    return AppUser(
      name: json["username"]??"",
      email: json["email"]??"",
      phone: json["phone"]??"",
      role: json["role"]??0,
      address: json["address"]??"",
    );
  }

  Map<String,dynamic> toJson() => {
    "username":name,
    "email":email,
    "phone":phone,
    "role":role,
    "address":address
  };
}