import '/features/actuation/domain/entities/media.dart';
class MediaModel extends Media{


   MediaModel({
    required super.id_actuacion,
     super.id_media,
    required super.tipo,
    required super.estado,
    required super.ruta,
    required super.crc,
    required super.duracion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_actuacion': id_actuacion,
      'id_media': id_media,
      'tipo': tipo,
      'estado': estado,
      'ruta': ruta,
      'crc': crc,
      'duracion': duracion,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id_actuacion: map['id_actuacion'] as int,
      id_media: map['id_media'] as int,
      tipo: map['tipo'] as String,
      estado: map['estado'] as String,
      ruta: map['ruta'] as String,
      crc: map['crc'] as String,
      duracion: map['duracion'] as int,
    );
  }

  MediaModel copyWith({
    int? id_actuacion,
    int? id_media,
    String? tipo,
    String? estado,
    String? ruta,
    String? crc,
    int? duracion,
  }) {
    return MediaModel(
      id_actuacion: id_actuacion ?? this.id_actuacion,
      id_media: id_media ?? this.id_media,
      tipo: tipo ?? this.tipo,
      estado: estado ?? this.estado,
      ruta: ruta ?? this.ruta,
      crc: crc ?? this.crc,
      duracion: duracion ?? this.duracion,
    );
  }

}