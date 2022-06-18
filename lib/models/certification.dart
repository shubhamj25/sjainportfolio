import 'dart:convert';

class Certification {
  Certification({
      this.title, 
      this.icon, 
      this.credential, 
      this.certificateUrl, 
      this.issuedOn, 
      this.org,});

  Certification.fromJson(dynamic json) {
    title = json['title'];
    icon = json['icon'];
    credential = json['credential'];
    certificateUrl = json['certificate_url'];
    issuedOn = json['issued_on'];
    org = json['org'];
  }
  String title;
  String icon;
  String credential;
  String certificateUrl;
  String issuedOn;
  String org;
Certification copyWith({  String title,
  String icon,
  String credential,
  String certificateUrl,
  String issuedOn,
  String org,
}) => Certification(  title: title ?? this.title,
  icon: icon ?? this.icon,
  credential: credential ?? this.credential,
  certificateUrl: certificateUrl ?? this.certificateUrl,
  issuedOn: issuedOn ?? this.issuedOn,
  org: org ?? this.org,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['icon'] = icon;
    map['credential'] = credential;
    map['certificate_url'] = certificateUrl;
    map['issued_on'] = issuedOn;
    map['org'] = org;
    return map;
  }
}