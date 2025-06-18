import 'finance_barat.dart';
import 'finance_pusat.dart';
import 'finance_timur.dart';
import 'gm_barat.dart';
import 'gm_timur.dart';
import 'hrd.dart';
import 'it.dart';
import 'legal.dart';
import 'logistik.dart';
import 'project_barat.dart';
import 'project_timur.dart';
import 'sales_barat.dart';
import 'sales_timur.dart';
import 'teknik.dart';

class Capaian {
  It? it;
  Hrd? hrd;
  Legal? legal;
  Logistik? logistik;
  GmTimur? gmTimur;
  GmBarat? gmBarat;
  FinancePusat? financePusat;
  FinanceTimur? financeTimur;
  FinanceBarat? financeBarat;
  SalesTimur? salesTimur;
  SalesBarat? salesBarat;
  ProjectTimur? projectTimur;
  ProjectBarat? projectBarat;
  Teknik? teknik;

  Capaian({
    this.it,
    this.hrd,
    this.legal,
    this.logistik,
    this.gmTimur,
    this.gmBarat,
    this.financePusat,
    this.financeTimur,
    this.financeBarat,
    this.salesTimur,
    this.salesBarat,
    this.projectTimur,
    this.projectBarat,
    this.teknik,
  });

  factory Capaian.fromJson(Map<String, dynamic> json) => Capaian(
        it: json['it'] == null
            ? null
            : It.fromJson(json['it'] as Map<String, dynamic>),
        hrd: json['hrd'] == null
            ? null
            : Hrd.fromJson(json['hrd'] as Map<String, dynamic>),
        legal: json['legal'] == null
            ? null
            : Legal.fromJson(json['legal'] as Map<String, dynamic>),
        logistik: json['logistik'] == null
            ? null
            : Logistik.fromJson(json['logistik'] as Map<String, dynamic>),
        gmTimur: json['gmTimur'] == null
            ? null
            : GmTimur.fromJson(json['gmTimur'] as Map<String, dynamic>),
        gmBarat: json['gmBarat'] == null
            ? null
            : GmBarat.fromJson(json['gmBarat'] as Map<String, dynamic>),
        financePusat: json['financePusat'] == null
            ? null
            : FinancePusat.fromJson(
                json['financePusat'] as Map<String, dynamic>),
        financeTimur: json['financeTimur'] == null
            ? null
            : FinanceTimur.fromJson(
                json['financeTimur'] as Map<String, dynamic>),
        financeBarat: json['financeBarat'] == null
            ? null
            : FinanceBarat.fromJson(
                json['financeBarat'] as Map<String, dynamic>),
        salesTimur: json['salesTimur'] == null
            ? null
            : SalesTimur.fromJson(json['salesTimur'] as Map<String, dynamic>),
        salesBarat: json['salesBarat'] == null
            ? null
            : SalesBarat.fromJson(json['salesBarat'] as Map<String, dynamic>),
        projectTimur: json['projectTimur'] == null
            ? null
            : ProjectTimur.fromJson(
                json['projectTimur'] as Map<String, dynamic>),
        projectBarat: json['projectBarat'] == null
            ? null
            : ProjectBarat.fromJson(
                json['projectBarat'] as Map<String, dynamic>),
        teknik: json['teknik'] == null
            ? null
            : Teknik.fromJson(json['teknik'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'it': it?.toJson(),
        'hrd': hrd?.toJson(),
        'legal': legal?.toJson(),
        'logistik': logistik?.toJson(),
        'gmTimur': gmTimur?.toJson(),
        'gmBarat': gmBarat?.toJson(),
        'financePusat': financePusat?.toJson(),
        'financeTimur': financeTimur?.toJson(),
        'financeBarat': financeBarat?.toJson(),
        'salesTimur': salesTimur?.toJson(),
        'salesBarat': salesBarat?.toJson(),
        'projectTimur': projectTimur?.toJson(),
        'projectBarat': projectBarat?.toJson(),
        'teknik': teknik?.toJson(),
      };

  static List<Capaian> fromJsonList(List? data) {
    return (data ?? []).map((e) => Capaian.fromJson(e)).toList();
  }
}
