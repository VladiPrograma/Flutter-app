import 'package:cicero_app/features/actuation/presentation/bloc/actuation_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/gf_toast.dart';
import '../../../../core/utils/gf_toast_postion.dart';
import '../../../../core/utils/time_utils.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key,required this.state}) : super(key: key);
final CameraState state;
  @override
  Widget build(BuildContext context) {
    return state.cameraStatusModel.isRecording
        ? InkWell(
      onTap: () {
        TextEditingController commentController =
        TextEditingController();
        int currentMillis = 150;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Insertar Comentario ${TimerUtils.formatMilliseconds(currentMillis)}'),
              content: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                    hintText: "Texto"),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Rechazar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () async {
                    // if (commentController
                    //     .value.text.isNotEmpty) {
                    //   ActuationComment
                    //   newComment =
                    //   ActuationComment(
                    //     performanceId: 111,
                    //     date: DateTime.now()
                    //         .toString(),
                    //     timeCode: currentMillis,
                    //     text: commentController
                    //         .value.text,
                    //   );
                    //   await DatabaseHelperActuationComment
                    //       .instance
                    //       .createActuationComment(
                    //       newComment)
                    //       .then((value) => {
                    //     GFToast.showToast(
                    //         "Comentario añadido con exito!",
                    //         toastPosition:
                    //         GFToastPosition
                    //             .BOTTOM,
                    //         backgroundColor:
                    //         Colors
                    //             .green,
                    //         textStyle: const TextStyle(
                    //             color: Colors
                    //                 .white),
                    //         context)
                    //   })
                    //       .onError((error,
                    //       stackTrace) =>
                    //   {
                    //     GFToast.showToast(
                    //         "Error al añadir comentario",
                    //         toastPosition:
                    //         GFToastPosition
                    //             .BOTTOM,
                    //         backgroundColor:
                    //         Colors
                    //             .red,
                    //         textStyle: const TextStyle(
                    //             color: Colors
                    //                 .white),
                    //         context)
                    //   });
                    // }
                    print(
                        "Comentario: ${commentController.text}");
                    print(
                        "Segundo del video: $currentMillis");

                    Navigator.of(context)
                        .pop(); // Cierra el diálogo
                  },
                ),
              ],
            );
          },
        );
      },
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: Colors.black38,
            size: 60,
          ),
          Icon(
            Icons.comment,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    )
        : Icon(
      Icons.circle,
      color: Colors.black38.withOpacity(0),
      size: 60,
    );
  }
}
