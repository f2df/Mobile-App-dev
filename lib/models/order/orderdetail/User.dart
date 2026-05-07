class User {
  User({
      required this.id,
      this.name, 
      this.img, 
      required this.mobile,
      this.email, 
      required this.otp,
      required this.userType,
      this.password, 
      required this.status,
      required this.role,
      this.gender, 
      this.googleId, 
      this.address, 
      this.type, 
      this.dukanName, 
      required this.userExist,
      this.reffralCode, 
      required this.createDate,
      required this.updateDate,
      this.intro,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name']??"";
    img = json['img']??"";
    mobile = json['mobile']??0;
    email = json['email'];
    otp = json['otp']??0;
    userType = json['userType'];
    password = json['password'];
    status = json['status'];
    role = json['role'];
    gender = json['gender'];
    googleId = json['googleId'];
    address = json['address'];
    type = json['type'];
    dukanName = json['dukanName']??"";
    userExist = json['userExist']??false;
    reffralCode = json['reffralCode']??"";
    createDate = json['createDate']??"";
    updateDate = json['updateDate']??"";
    intro = json['intro'];
  }
  int id=0;
  dynamic name="";
  dynamic img="";
  int mobile=0;
  dynamic email="";
  int otp=0;
  String userType="";
  dynamic password="";
  bool status=false;
  String role="";
  dynamic gender="";
  dynamic googleId=0;
  dynamic address;
  dynamic type;
  dynamic dukanName;
  bool userExist=true;
  dynamic reffralCode;
  String createDate="";
  String updateDate="";
  dynamic intro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['img'] = img;
    map['mobile'] = mobile;
    map['email'] = email;
    map['otp'] = otp;
    map['userType'] = userType;
    map['password'] = password;
    map['status'] = status;
    map['role'] = role;
    map['gender'] = gender;
    map['googleId'] = googleId;
    map['address'] = address;
    map['type'] = type;
    map['dukanName'] = dukanName??"";
    map['userExist'] = userExist??false;
    map['reffralCode'] = reffralCode??"";
    map['createDate'] = createDate??"";
    map['updateDate'] = updateDate??"";
    map['intro'] = intro;
    return map;
  }

}