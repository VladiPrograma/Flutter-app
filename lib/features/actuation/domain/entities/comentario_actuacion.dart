class Comment {
  final int id_actuacion; //performance identifier
   int? id_comentario;// comment identifier
  final DateTime fecha; //date/time of the comment
  final int tc; //timecode in ms from the start of the video
  final String txt;//text of the comment


   Comment({
    required this.id_actuacion,
     this.id_comentario,
    required this.fecha,
    required this.tc,
    required this.txt,
  });


}