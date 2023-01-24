class Consonant{
  int? id;
  String? consonant;
  String? image;
  // String? video;

  Consonant({this.id,this.consonant,this.image});

  factory Consonant.fromMap(map){
    return Consonant(
      id:map['id'],
      consonant:map['consonant'],
      image:map['image'],
      // video:map['video'],
    );
  }
}