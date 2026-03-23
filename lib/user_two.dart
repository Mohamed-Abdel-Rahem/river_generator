import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserProfile {
  final String name;
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String webSite;
  final Address address;
  final Company company;
  UserProfile({
    required this.name,
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.webSite,
    required this.address,
    required this.company,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      userName: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      webSite: json['website'] ?? '',
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }

  UserProfile copyWith({
    String? name,
    int? id,
    String? userName,
    String? email,
    String? phone,
    String? webSite,
    Address? address,
    Company? company,
  }) {
    return UserProfile(
      name: name ?? this.name,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      webSite: webSite ?? this.webSite,
      address: address ?? this.address,
      company: company ?? this.company,
    );
  }

  @override
  String toString() {
    return 'UserProfile(name: $name, id: $id, userName: $userName, email: $email, phone: $phone, webSite: $webSite, address: $address, company: $company)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.userName == userName &&
        other.email == email &&
        other.phone == phone &&
        other.webSite == webSite &&
        other.address == address &&
        other.company == company;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        webSite.hashCode ^
        address.hashCode ^
        company.hashCode;
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  final String lat;
  final String lng;
  Geo({required this.lat, required this.lng});
  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(lat: json['lat'] ?? '', lng: json['lng'] ?? '');
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;
  Company({required this.name, required this.catchPhrase, required this.bs});
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] ?? '',
      catchPhrase: json['catchPhrase'] ?? '',
      bs: json['bs'] ?? '',
    );
  }
}

final userProviderRepositry = Provider((ref) => UserRepository());

class UserRepository {
  Future<UserProfile> featchUserData() async {
    const targetUrl = 'https://jsonplaceholder.typicode.com/users/4';
    // استخدم بروكسي تاني أسرع شوية ومخصص للمطورين
    final proxyUrl =
        'https://api.allorigins.win/get?url=${Uri.encodeComponent(targetUrl)}';

    try {
      final response = await http
          .get(Uri.parse(proxyUrl))
          .timeout(
            const Duration(
              seconds: 15,
            ), // لو زاد عن 15 ثانية اقطع وقوله حاول تاني
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> fullResponse = jsonDecode(response.body);
        // allorigins في الـ /get بيرجع الداتا جوه حقل اسمه 'contents'
        final String contents = fullResponse['contents'];
        final Map<String, dynamic> data = jsonDecode(contents);

        return UserProfile.fromJson(data);
      } else {
        throw Exception('Server Error');
      }
    } catch (e) {
      throw Exception('الشبكة ضعيفة، جارٍ إعادة المحاولة...');
    }
  }
}
