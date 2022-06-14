class dataModel{
    int id,userid;
    String body,title;
 dataModel({required this.body,required this.id,required this.title,required this.userid});

 factory dataModel.fromMap(Map <String, dynamic> map){
   return  dataModel(body: map['body'] as String, id: map['id'] as int, title: map['title'] as String, userid: map['userId'] as int);
 }
 Map<String,dynamic> toMap(){
   return {
     'id' : this.id,
     'userId' : this.userid,
     'title': this.title,
     'body':this.body,
   } as Map<String,dynamic>;
 }
}