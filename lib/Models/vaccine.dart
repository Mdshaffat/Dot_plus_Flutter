class Vaccine {
  final int value;
  final String name;
  Vaccine({required this.value, required this.name});
}

class NewVaccine {
  NewVaccine();
  List<Vaccine> covidVaccine = [
    Vaccine(value: 1, name: "Yes"),
    Vaccine(value: 2, name: "No")
  ];

  List<Vaccine> vaccineBrand = [
    Vaccine(value: 1, name: "Pfizer"),
    Vaccine(value: 2, name: "Astrazeneca"),
    Vaccine(value: 3, name: "Moderna"),
    Vaccine(value: 4, name: "Sinopharm"),
    Vaccine(value: 5, name: "Others"),
  ];

  List<Vaccine> vaccineDose = [
    Vaccine(value: 1, name: "1st Dose"),
    Vaccine(value: 2, name: "2nd Dose"),
    Vaccine(value: 3, name: "Boster Dose"),
  ];
}
