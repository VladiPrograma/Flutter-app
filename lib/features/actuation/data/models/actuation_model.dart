import '/features/actuation/domain/entities/actuation.dart';

class ActuationModel extends Actuation {
  ActuationModel({
    required super.id_organo, required super.nombre_organo, required super.id_tipo_organo, required super.descripcion_tipo_organo, required super.id_procedimiento, required super.nombre_procedimiento, required super.id_tipo_procedimiento, required super.descripcion_tipo_procedimiento,  super.id_actuacion, required super.id_tipo_actuacion, required super.descripcion_tipo_actuacion, required super.fecha_inicio_actuacion, required super.fecha_fin_actuacion, required super.estado_actuacion, required super.sincronizada});


  Map<String, dynamic> toMap() {
    return {
     if(id_actuacion!=null) 'id_actuacion': id_actuacion,
      'id_organo': id_organo,
      'nombre_organo': nombre_organo,
      'id_tipo_organo': id_tipo_organo,
      'descripcion_tipo_organo': descripcion_tipo_organo,
      'id_procedimiento': id_procedimiento,
      'nombre_procedimiento': nombre_procedimiento,
      'id_tipo_procedimiento': id_tipo_procedimiento,
      'descripcion_tipo_procedimiento': descripcion_tipo_procedimiento,
      'id_tipo_actuacion': id_tipo_actuacion,
      'descripcion_tipo_actuacion': descripcion_tipo_actuacion,
      'fecha_inicio_actuacion': fecha_inicio_actuacion.toIso8601String(),
      'fecha_fin_actuacion': fecha_fin_actuacion.toIso8601String(),
      'estado_actuacion': estado_actuacion,
      'sincronizada': sincronizada,
    };
  }

  factory ActuationModel.fromMap(Map<String, dynamic> map) {
    return ActuationModel(
      id_organo: map['id_organo'] as int,
      nombre_organo: map['nombre_organo'] as String,
      id_tipo_organo: map['id_tipo_organo'] as int,
      descripcion_tipo_organo: map['descripcion_tipo_organo'] as String,
      id_procedimiento: map['id_procedimiento'] as int,
      nombre_procedimiento: map['nombre_procedimiento'] as String,
      id_tipo_procedimiento: map['id_tipo_procedimiento'] as int,
      descripcion_tipo_procedimiento:
      map['descripcion_tipo_procedimiento'] as String,
      id_actuacion: map['id_actuacion'] as int,
      id_tipo_actuacion: map['id_tipo_actuacion'] as int,
      descripcion_tipo_actuacion: map['descripcion_tipo_actuacion'] as String,
      fecha_inicio_actuacion: DateTime.parse(map['fecha_inicio_actuacion'] as String),
      fecha_fin_actuacion: DateTime.parse(map['fecha_fin_actuacion'] as String),
      estado_actuacion: map['estado_actuacion'] as String,
      sincronizada: map['sincronizada'] as String,
    );
  }

  ActuationModel copyWith({
    int? id_organo,
    String? nombre_organo,
    int? id_tipo_organo,
    String? descripcion_tipo_organo,
    int? id_procedimiento,
    String? nombre_procedimiento,
    int? id_tipo_procedimiento,
    String? descripcion_tipo_procedimiento,
    int? id_actuacion,
    int? id_tipo_actuacion,
    String? descripcion_tipo_actuacion,
    DateTime? fecha_inicio_actuacion,
    DateTime? fecha_fin_actuacion,
    String? estado_actuacion,
    String? sincronizada,
  }) {
    return ActuationModel(
      id_organo: id_organo ?? this.id_organo,
      nombre_organo: nombre_organo ?? this.nombre_organo,
      id_tipo_organo: id_tipo_organo ?? this.id_tipo_organo,
      descripcion_tipo_organo:
      descripcion_tipo_organo ?? this.descripcion_tipo_organo,
      id_procedimiento: id_procedimiento ?? this.id_procedimiento,
      nombre_procedimiento: nombre_procedimiento ?? this.nombre_procedimiento,
      id_tipo_procedimiento:
      id_tipo_procedimiento ?? this.id_tipo_procedimiento,
      descripcion_tipo_procedimiento:
      descripcion_tipo_procedimiento ?? this.descripcion_tipo_procedimiento,
      id_actuacion: id_actuacion ?? this.id_actuacion,
      id_tipo_actuacion: id_tipo_actuacion ?? this.id_tipo_actuacion,
      descripcion_tipo_actuacion:
      descripcion_tipo_actuacion ?? this.descripcion_tipo_actuacion,
      fecha_inicio_actuacion:
      fecha_inicio_actuacion ?? this.fecha_inicio_actuacion,
      fecha_fin_actuacion: fecha_fin_actuacion ?? this.fecha_fin_actuacion,
      estado_actuacion: estado_actuacion ?? this.estado_actuacion,
      sincronizada: sincronizada ?? this.sincronizada,
    );
  }
}
