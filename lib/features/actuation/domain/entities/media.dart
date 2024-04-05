class Media{
  final int id_actuacion; //performance identifier
   int? id_media; //media identifier
  final String tipo; //type of media; initially only recording type
  final String estado; //state of the media; capturing, captured
  final String ruta; //local path of the media
  final String crc; //media crc
  final int duracion;// duration in ms


   Media({
    required this.id_actuacion,
     this.id_media,
    required this.tipo,
    required this.estado,
    required this.ruta,
    required this.crc,
    required this.duracion,
  });


}