import 'package:flutter/widgets.dart';

class ErrorMessage extends StatelessWidget {
  final Object error;
  final Function callBack;

  const ErrorMessage({
    required this.error,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callBack.call();
      },
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
