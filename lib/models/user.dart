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
      this.mapLink,
      this.mobile,
      this.address,
      this.gitUsername,
      this.skills,
      this.schooling,
      this.highSchool,
      this.college,
      this.career,
      this.projects,
      this.linkedInUrl,
        this.currentCompanyLogo,
      this.fbUrl,
      this.resumeLink});

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
      mapLink: json['map_link'],
      mobile: json['mobile'],
      address: json['address'],
      gitUsername: json['git_username'],
      fbUrl: json['fb_url'],
      linkedInUrl: json['linkedin_url'],
      coverUrl: json['cover_url'],
      projectCoverUrl: json['project_cover_url'],
      skills: skillSet,
      schooling: json['schooling'],
      highSchool: json['highSchool'],
      resumeLink: json['resume_link'],
      currentCompanyLogo: json['current_company_logo'],
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
  String mapLink;
  String mobile;
  String address;
  String gitUsername;
  String linkedInUrl;
  String fbUrl;
  String coverUrl;
  String projectCoverUrl;
  String schooling;
  String highSchool;
  String resumeLink;
  String currentCompanyLogo;
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
    map['map_link'] = mapLink;
    map['mobile'] = mobile;
    map['address'] = address;
    map['git_username'] = gitUsername;
    map['cover_url'] = coverUrl;
    map['project_cover_url'] = projectCoverUrl;
    map['schooling'] = schooling;
    map['highSchooling'] = highSchool;
    map['linkedin_url'] = linkedInUrl;
    map['fb_url'] = fbUrl;
    map['resume_link'] = resumeLink;
    map['current_company_logo']=currentCompanyLogo;
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
