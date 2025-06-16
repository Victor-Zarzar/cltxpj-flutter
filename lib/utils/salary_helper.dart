double calculateInss(double grossSalary) {
  if (grossSalary <= 1518.00) {
    return grossSalary * 0.075;
  } else if (grossSalary <= 2793.88) {
    return (1518.00 * 0.075) + ((grossSalary - 1518.00) * 0.09);
  } else if (grossSalary <= 4190.83) {
    return (1518.00 * 0.075) +
        ((2793.88 - 1518.00) * 0.09) +
        ((grossSalary - 2793.88) * 0.12);
  } else if (grossSalary <= 8157.41) {
    return (1518.00 * 0.075) +
        ((2793.88 - 1518.00) * 0.09) +
        ((4190.83 - 2793.88) * 0.12) +
        ((grossSalary - 4190.83) * 0.14);
  } else {
    return 1236.70;
  }
}

double calculateIrrf(double grossSalary) {
  final inss = calculateInss(grossSalary);
  final base = grossSalary - inss;

  if (base <= 2428.80) {
    return 0.0;
  } else if (base <= 2826.65) {
    return (base * 0.075) - 182.16;
  } else if (base <= 3751.05) {
    return (base * 0.15) - 394.16;
  } else if (base <= 4664.68) {
    return (base * 0.225) - 675.49;
  } else {
    return (base * 0.275) - 908.73;
  }
}
