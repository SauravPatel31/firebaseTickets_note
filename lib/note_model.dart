class NoteModel{
  String? title;
  String? description;
  String? createAt;

  NoteModel({this.title, this.description, this.createAt});

  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
      title: map['title'],
      description: map['desc'],
      createAt: map['createAt'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "title":title,
      "desc":description,
      "createAt":createAt
    };
  }
}