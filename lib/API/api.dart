const String ROOTURI = 'google.com';
const String ROOT = "https://192.168.0.102:5001/api";
// const String ROOT = "https://dotplusapi.azurewebsites.net/api";
//const String ROOT = "https://hospitalapitest.azurewebsites.net/api";
const String LOGIN = "$ROOT/account/login";
const String HOSPITALURI = "$ROOT/hospital/hospitallistsortbyname";
const String DIVISIONURI = "$ROOT/upazilaanddistrict/division";
const String DISTRICTURI = "$ROOT/upazilaanddistrict/divisionwisedistrict/";
const String UPAZILAURI = "$ROOT/upazilaanddistrict/districtwiseupazila/";
const String ALLDISTRICTURI = "$ROOT/upazilaanddistrict/district";
const String ALLUPAZILAURI = "$ROOT/upazilaanddistrict/upazila";

// patient

const String PATIENTURI = "$ROOT/patient";
const String PATIENTSEARCHURI = "$ROOT/patient/patientSearch";
//patient History
const String PATIENTHISTORYURI = "$ROOT/patient/patienthistory";

const String PRESCRIPTIONURI = "$ROOT/prescription";
const String PHYSICALSTATURI = "$ROOT/physicalState";
const String PRESCRIPTIONADD = "$ROOT/prescription/postprescriptionapp";

const String USERS = "$ROOT/userManagement/doctorlist";
const String TELEMEDICINEURI = "$ROOT/telemedicine";
const String MEDICINEURI = "$ROOT/medicine/medicinesync";
const String DISEASECATEGORYURI = "$ROOT/diagnoses/diseasescategory";
const String DISEASEURI = "$ROOT/diagnoses/diseases";

//report

const String PATIENTCOUNT = "$ROOT/homepagereport/usernameandtotalpatient";
const String PRESCRIPTIONCOUNT =
    "$ROOT/homepagereport/usernameandtotalprescription";
