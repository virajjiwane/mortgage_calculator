import 'dart:math';

double getMonthlyInstallment({
  required int principalAmount,
  required int months,
  required double interestRate,
}) {
  double monthlyInstallments = 0;
  double increment = interestRate + 1;

  monthlyInstallments = principalAmount * (interestRate * pow(increment, months)) / (pow(increment, months) - 1);
  return monthlyInstallments;
}
