class MeModel{
  int id;
  String username,email,fullName;

  MeModel(this.id, this.username, this.email, this.fullName);
  MeModel.fromJson(Map<String,dynamic> map){
    this.id=map['id'];
    this.username=map['username'];
    this.email=map['email'];
    this.fullName=map['fullName'];
    // this.image=map['image'];
  }

   }