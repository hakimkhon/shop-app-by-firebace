import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool loadingIcon;
  final bool centerTitle;
  final List<Widget>? actions;

  const MyAppBar({
    super.key,
    this.actions,
    required this.title,
    this.loadingIcon = false,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
      automaticallyImplyLeading: loadingIcon,
      // backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}