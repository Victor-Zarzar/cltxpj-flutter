double calculateInss(double grossSalary) {
  if (grossSalary <= 1412.00) {
    return grossSalary * 0.075;
  } else if (grossSalary <= 2666.68) {
    return (1412.00 * 0.075) + ((grossSalary - 1412.00) * 0.09);
  } else if (grossSalary <= 4000.03) {
    return (1412.00 * 0.075) +
        ((2666.68 - 1412.00) * 0.09) +
        ((grossSalary - 2666.68) * 0.12);
  } else if (grossSalary <= 7786.02) {
    return (1412.00 * 0.075) +
        ((2666.68 - 1412.00) * 0.09) +
        ((4000.03 - 2666.68) * 0.12) +
        ((grossSalary - 4000.03) * 0.14);
  } else {
    return 908.85;
  }
}

double calculateIrrf(double grossSalary) {
  final inss = calculateInss(grossSalary);
  final taxableIncome = grossSalary - inss;

  if (taxableIncome <= 2259.20) {
    return 0.0;
  } else if (taxableIncome <= 2826.65) {
    return (taxableIncome * 0.075) - 169.44;
  } else if (taxableIncome <= 3751.05) {
    return (taxableIncome * 0.15) - 381.44;
  } else if (taxableIncome <= 4664.68) {
    return (taxableIncome * 0.225) - 662.77;
  } else {
    return (taxableIncome * 0.275) - 896.00;
  }
}
