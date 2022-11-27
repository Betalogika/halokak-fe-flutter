import 'package:flutter/material.dart';
import 'package:halokak_app/data/local/text_storage.dart';

// Future<dynamic> showProgressDialog(BuildContext context){
//   AlertDialog alert=AlertDialog(
//     content: Row(
//       children: [
//         const CircularProgressIndicator(),
//         Container(margin: const EdgeInsets.only(left: 7), child:const Text(TextStorage.lblLoading)),
//       ],),
//   );
//   return showDialog(barrierDismissible: true,
//     context:context,
//     builder:(BuildContext context){
//       return alert;
//     },
//   );
// }

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(
                  text: text
              ),
            )
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget{
  const LoadingIndicator({super.key, this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              _getText(displayedText)
            ]
        )
    );
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
                strokeWidth: 3.0
            )
        )
    );
  }

  Widget _getHeading(context) {
    return
      const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            TextStorage.lblLoading,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          )
      );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 14
      ),
      textAlign: TextAlign.center,
    );
  }
}