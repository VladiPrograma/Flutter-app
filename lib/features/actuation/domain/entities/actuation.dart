class Actuation {
  final int id_organo; //identifier of the organ
  final String nombre_organo; //name of the organ
  final int id_tipo_organo; //identifier of the type of organ
  final String descripcion_tipo_organo; //description of the type of organ
  final int id_procedimiento; //identifier of the procedure
  final String nombre_procedimiento; //name of the procedure
  final int id_tipo_procedimiento; //identifier of the type of procedure
  final String descripcion_tipo_procedimiento; //description of the type of procedure
   int? id_actuacion; //performance identifier
  final int id_tipo_actuacion; //identifier of the type of performance
  final String descripcion_tipo_actuacion; //description of the type of performance
  final DateTime  fecha_inicio_actuacion; //start date of the performance recording
  final DateTime fecha_fin_actuacion; //end date of the performance recording
  final String estado_actuacion; //status of the performance; prepared, recorded
  final String sincronizada;

  Actuation({required this.id_organo, required this.nombre_organo, required this.id_tipo_organo, required this.descripcion_tipo_organo, required this.id_procedimiento, required this.nombre_procedimiento, required this.id_tipo_procedimiento, required this.descripcion_tipo_procedimiento, required this.id_actuacion, required this.id_tipo_actuacion, required this.descripcion_tipo_actuacion, required this.fecha_inicio_actuacion, required this.fecha_fin_actuacion, required this.estado_actuacion, required this.sincronizada});


}
