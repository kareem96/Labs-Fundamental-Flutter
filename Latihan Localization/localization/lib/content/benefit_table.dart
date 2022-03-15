

import 'package:flutter/material.dart';
import 'package:localization/classes/benefit_feature.dart';
import 'package:localization/widget/table_cell_widget.dart';

class BenefitTable extends StatelessWidget {
  const BenefitTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final benefitFeatureList = [
      BenefitFeature("akses semua kelas", true, true),
      BenefitFeature("ujian", true, true),
      BenefitFeature("kirim submission", false, true),
    ];
    return Table(
      border: TableBorder.all(width: 0.5),
      columnWidths: const<int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children:  [
        const TableRow(children: [
          TableCellWidget(
              text: 'Fiture Utama',
              isBold: true,
          ),
          TableCellWidget(
            text: "Uji Coba",
            isBold: true,
          ),
          TableCellWidget(
            text: "Langganan",
            isBold: true,
          )
        ]),
        ...benefitFeatureList.map((benefitFeature) {
          return  TableRow(
            children: [
              TableCellWidget(
                text: benefitFeature.feature,
              ),
              TableCellWidget(
                check: benefitFeature.freeBenefit,
              ),
              TableCellWidget(
                check: benefitFeature.paidBenefit,
              ),
            ]
          );
        }).toList(),
      ],
    );
  }
}
