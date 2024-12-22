import 'package:flutter/material.dart';
import 'package:optimus_case/utils/extensions.dart/theme_extension.dart';
import 'package:optimus_case/views/time_zone_details/area_detail_entity.dart';

class AreaDetailTexts extends StatelessWidget {
  final List<AreaDetailEntity> areaDetailTexts;

  const AreaDetailTexts({
    required this.areaDetailTexts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: areaDetailTexts.map((detail) {
        return Column(
          children: [
            Text(
              detail.content,
              style: detail.contentStyle ?? context.textStyles.regular3,
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}
