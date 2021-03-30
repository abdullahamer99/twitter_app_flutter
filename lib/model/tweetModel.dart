class TweetsModel{
int id,myUserId;
String description,image,username,userImage,userFullName;


TweetsModel(this.id, this.myUserId, this.description, this.image,
      this.username, this.userImage,this.userFullName);

  TweetsModel.fromJson(Map<String,dynamic> map){
  this.id=map["id"];
  this.myUserId=map['users_permissions_user']['id'];
  this.username=map['users_permissions_user']['username'];
  this.userFullName=map['users_permissions_user']['fullName'];
  this.userImage=map['users_permissions_user']['image'];
  this.description=map["description"];
  this.image=map["image"]!= null?map["image"]["url"]:null;


  }
}