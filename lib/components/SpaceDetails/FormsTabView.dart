import 'package:flutter/material.dart';
import 'package:ottersync/components/Common/AppSurface.dart';
import 'package:ottersync/theme/design_tokens.dart';

class FormsTabView extends StatelessWidget {
  const FormsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpace.pagePaddingWithNav,
      children: const [
        AppSurface(child: Text('表单页保持与其他子页一致的卡片、边框和排版层级，作为空间详情的占位内容。')),
      ],
    );
  }
}
