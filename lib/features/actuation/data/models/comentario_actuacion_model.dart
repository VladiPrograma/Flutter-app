import '/features/actuation/domain/entities/comentario_actuacion.dart';

class CommentModel extends Comment{

   CommentModel({
    required super.id_actuacion,
     super.id_comentario,
    required super.fecha,
    required super.tc,
    required super.txt,
  });
  Map<String, dynamic> toMap() {
    return {
      if(id_comentario!=null)'id_comentario': id_comentario,
      'id_actuacion': id_actuacion,
      'fecha': fecha.toIso8601String(),
      'tc': tc,
      'txt': txt,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id_actuacion: map['id_actuacion'] as int,
      id_comentario: map['id_comentario'] as int,
      fecha: DateTime.parse(map['fecha'] as String),
      tc: map['tc'] as int,
      txt: map['txt'] as String,
    );
  }

  CommentModel copyWith({
    int? id_actuacion,
    int? id_comentario,
    DateTime? fecha,
    int? tc,
    String? txt,
  }) {
    return CommentModel(
      id_actuacion: id_actuacion ?? this.id_actuacion,
      id_comentario: id_comentario ?? this.id_comentario,
      fecha: fecha ?? this.fecha,
      tc: tc ?? this.tc,
      txt: txt ?? this.txt,
    );
  }
}