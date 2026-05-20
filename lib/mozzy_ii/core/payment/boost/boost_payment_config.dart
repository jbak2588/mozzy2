class BoostPackage {
  final String packageId;
  final int amountIdr;
  final int durationDays;
  final String label;

  const BoostPackage({
    required this.packageId,
    required this.amountIdr,
    required this.durationDays,
    required this.label,
  });
}

class BoostPaymentConfig {
  static const List<BoostPackage> packages = [
    BoostPackage(
      packageId: 'boost_1d',
      amountIdr: 15000,
      durationDays: 1,
      label: '1 Hari',
    ),
    BoostPackage(
      packageId: 'boost_3d',
      amountIdr: 35000,
      durationDays: 3,
      label: '3 Hari',
    ),
    BoostPackage(
      packageId: 'boost_7d',
      amountIdr: 70000,
      durationDays: 7,
      label: '7 Hari',
    ),
  ];

  static BoostPackage getPackage(String packageId) {
    return packages.firstWhere(
      (p) => p.packageId == packageId,
      orElse: () => packages.first,
    );
  }
}
