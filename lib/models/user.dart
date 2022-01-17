import 'package:myportfolio/models/project.dart';

class User {
  User(
      {this.name,
      this.avatarUrl,
      this.drawerDesc,
      this.coverUrl,
      this.projectCoverUrl,
      this.bio,
      this.email,
      this.mobile,
      this.address,
      this.gitUrl,
      this.skills,
      this.schooling,
      this.highSchool,
      this.college,
      this.career,
      this.projects,
      this.linkedInUrl,
        this.fbUrl,
      });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Skills> skillSet = [];
    List<String> collegeStats = [];
    List<String> careerStats = [];
    List<Project> projects = [];
    if (json['skills'] != null) {
      json['skills'].forEach((v) {
        skillSet.add(Skills.fromJson(v));
      });
    }
    if (json['career'] != null) {
      json['career'].forEach((v) {
        careerStats.add(v.toString());
      });
    }
    if (json['college'] != null) {
      json['college'].forEach((v) {
        collegeStats.add(v.toString());
      });
    }
    if (json['projects'] != null) {
      json['projects'].forEach((v) {
        projects.add(Project.fromJson(v));
      });
    }
    User user = User(
        name: json['name'],
        avatarUrl: json['avatar_url'],
        drawerDesc: json['drawer_desc'],
        bio: json['bio'],
        email: json['email'],
        mobile: json['mobile'],
        address: json['address'],
        gitUrl: json['git_url'],
        fbUrl: json['fb_url'],
        linkedInUrl: json['linkedin_url'],
        coverUrl: json['cover_url'],
        projectCoverUrl: json['project_cover_url'],
        skills: skillSet,
        schooling: json['schooling'],
        highSchool: json['highSchool'],
        college: collegeStats,
        career: careerStats,
        projects: projects,
    );
    return user;
  }

  String name;
  String avatarUrl;
  String drawerDesc;
  String bio;
  String email;
  String mobile;
  String address;
  String gitUrl;
  String linkedInUrl;
  String fbUrl;
  String coverUrl;
  String projectCoverUrl;
  String schooling;
  String highSchool;
  List<String> college;
  List<String> career;
  List<Skills> skills;
  List<Project> projects;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['avatar_url'] = avatarUrl;
    map['drawer_desc'] = drawerDesc;
    map['bio'] = bio;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['git_url'] = gitUrl;
    map['cover_url'] = coverUrl;
    map['project_cover_url'] = projectCoverUrl;
    map['schooling'] = schooling;
    map['highSchooling'] = highSchool;
    map['linkedin_url'] = linkedInUrl;
    map['fb_url'] =  fbUrl;
    if (skills != null) {
      map['skills'] = skills?.map((v) => v.toJson())?.toList();
    }
    if (college != null) {
      map['college'] = college.map((v) => v.toString()).toList();
    }
    if (career != null) {
      map['career'] = career.map((v) => v.toString()).toList();
    }
    if (projects != null) {
      map['projects'] = projects.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Skills {
  Skills({
    this.title,
    this.level,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(title: json['title'], level: json['level']);
  }

  String title;
  String level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['level'] = level;
    return map;
  }
}
