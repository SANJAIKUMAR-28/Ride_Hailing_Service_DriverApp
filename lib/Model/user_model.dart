class UserModel{
  String? uid;
  String? email;
  String? name;
  String? phoneno;
  String? stars;
  String? feedbacks;
  UserModel({this.uid,this.email,this.name,this.phoneno,this.stars,this.feedbacks});
  //recieve data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid:map['uid'],
        email:map['email'],
        name:map['name'],
        phoneno: map['phoneno'],
      stars:map['stars'],
      feedbacks:map['feedbacks'],
    );
  }
  //send data to server
  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'name':name,
      'phoneno':phoneno,
      'stars':stars,
      'feedbacks':feedbacks,
    };
  }

}