// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop/cubit/auth/auth_cubit.dart';
// import 'package:shop/data/enums/forms_status.dart';

// class MyTextButtonWidget extends StatelessWidget {
//   final String data;
//   final Function onPressed;
//   const MyTextButtonWidget({
//     super.key,
//     required this.data,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//           backgroundColor: Colors.blue),
//       onPressed: onPressed(),
//       child: context.watch<AuthCubit>().state.formsStatus == FormsStatus.loading
//           ? const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             )
//           : Text(
//               data,
//               style: TextStyle(color: Colors.white, fontSize: 17),
//             ),
//     );
//   }
// }
