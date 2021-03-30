class UserModel{
  int id;
  String username,email,fullName,image,bannar;

  UserModel(this.id, this.username, this.email, this.fullName, this.image,
      this.bannar);
  UserModel.fromJson(Map<String,dynamic> map){
  this.id=map['id'];
  this.username=map['username'];
  this.email=map['email'];
  this.fullName=map['fullName'];
  this.image=map["image"]!= null?map["image"]["url"]:null;
  this.bannar=map["bannar"]!= null?map["bannar"]["url"]:null;

  }

}