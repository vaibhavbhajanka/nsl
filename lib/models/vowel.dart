class Vowel{
  int? id;
  String? vowel;
  String? image;
  String? video;

  Vowel({this.id,this.vowel,this.image,this.video});

  factory Vowel.fromMap(map){
    return Vowel(
      id:map['id'],
      vowel:map['vowel'],
      image:map['image'],
      video:map['video'],
    );
  }
}