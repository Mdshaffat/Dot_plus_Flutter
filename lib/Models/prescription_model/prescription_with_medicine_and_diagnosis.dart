import '../../Models/diseaseAndMedicine/diagnosis.dart';
import '../../Models/diseaseAndMedicine/medicine_for_prescription.dart';
import '../../Models/prescription_model/prescription_dto.dart';

class PrescriptionWithMedicineAndDiagnosis {
  PrescriptionDto prescriptionDto;
  List<Diagnosis> diagnosisList;
  List<MedicineForPrescription> medicineForPrescription;

  PrescriptionWithMedicineAndDiagnosis(
      {required this.prescriptionDto,
      required this.diagnosisList,
      required this.medicineForPrescription});

  Map<String, dynamic> toJson() => {
        "prescriptionDto": prescriptionDto.toJson(),
        "diagnosisList":
            List<dynamic>.from(diagnosisList.map((x) => x.toJson())),
        "medicineForPrescription":
            List<dynamic>.from(medicineForPrescription.map((x) => x.toJson())),
      };
}
