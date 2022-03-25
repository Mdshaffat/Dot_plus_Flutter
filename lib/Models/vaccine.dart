class Vaccine {
  final int Value;
  final String Name;
  Vaccine({required this.Value, required this.Name});
}

class NewVaccine {
  NewVaccine();
  List<Vaccine> covidVaccine = [
    Vaccine(Value: 1, Name: "Yes"),
    Vaccine(Value: 2, Name: "No")
  ];

  List<Vaccine> vaccineBrand = [
    Vaccine(Value: 1, Name: "Pfizer"),
    Vaccine(Value: 2, Name: "Astrazeneca"),
    Vaccine(Value: 3, Name: "Moderna"),
    Vaccine(Value: 4, Name: "Sinopharm"),
    Vaccine(Value: 5, Name: "Others"),
  ];

  List<Vaccine> vaccineDose = [
    Vaccine(Value: 1, Name: "1st Dose"),
    Vaccine(Value: 2, Name: "2nd Dose"),
    Vaccine(Value: 3, Name: "Boster Dose"),
  ];
}
