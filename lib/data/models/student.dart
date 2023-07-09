class Student {
  Student(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.currentAddress,
      required this.permanentAddress,
      required this.email,
      required this.mobile,
      required this.image,
      required this.dob,
      required this.status,
      required this.userId,
      required this.admissionNo,
      required this.rollNumber,
      required this.caste,
      required this.religion,
      required this.admissionDate,
      required this.bloodGroup,
      required this.height,
      required this.weight,
      required this.categoryName,
      required this.classSectionName,
      required this.mediumName});
  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String currentAddress;
  late final String permanentAddress;
  late final String mobile;
  late final String image;
  late final String dob;
  late final int status;
  late final int userId;
  late final String admissionNo;
  late final String rollNumber;
  late final String caste;
  late final String religion;
  late final String admissionDate;
  late final String bloodGroup;
  late final String height;
  late final String weight;
  late final String classSectionName;
  late final String mediumName;
  late final String categoryName;

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;

    lastName = json['last_name'] ?? "";
    firstName = json['first_name'] ?? "";
    currentAddress = json['current_address'] ?? "";
    permanentAddress = json['permanent_address'] ?? "";

    email = json['email'] ?? "";
    mobile = json['mobile'] ?? "";
    image = json['image'] ?? "";
    dob = json['dob'] ?? "";
    status = json['status'] ?? 0;
    userId = json['user_id'] ?? 0;
    admissionNo = json['admission_no'] ?? "";
    rollNumber = json['roll_number'] ?? "";
    caste = json['caste'] ?? "";
    religion = json['religion'] ?? "";
    admissionDate = json['admission_date'] ?? "";
    bloodGroup = json['blood_group'] ?? "";
    height = json['height'] ?? "";
    weight = json['weight'] ?? "";
    classSectionName = json['class_section_name'] ?? "";
    mediumName = json['medium_name'] ?? "";
    categoryName = json['category_name'] ?? "";
  }

  String getFullName() {
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['last_name'] = lastName;
    _data['first_name'] = firstName;
    _data['current_address'] = currentAddress;
    _data['permanent_address'] = permanentAddress;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['image'] = image;
    _data['dob'] = dob;
    _data['status'] = status;
    _data['user_id'] = userId;
    _data['admission_no'] = admissionNo;
    _data['roll_number'] = rollNumber;
    _data['caste'] = caste;
    _data['religion'] = religion;
    _data['admission_date'] = admissionDate;
    _data['blood_group'] = bloodGroup;
    _data['height'] = height;
    _data['weight'] = weight;
    _data['class_section_name'] = classSectionName;
    _data['medium_name'] = mediumName;
    _data['category_name'] = categoryName;
    return _data;
  }
}
