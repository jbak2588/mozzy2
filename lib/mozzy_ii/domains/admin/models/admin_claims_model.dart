class AdminClaimsModel {
  final bool isAdmin;
  final String? adminRole; // super_admin, ops_admin, finance_admin, support_admin
  final DateTime? claimsUpdatedAt;

  const AdminClaimsModel({
    this.isAdmin = false,
    this.adminRole,
    this.claimsUpdatedAt,
  });

  factory AdminClaimsModel.fromJson(Map<String, dynamic> json) {
    return AdminClaimsModel(
      isAdmin: json['isAdmin'] as bool? ?? false,
      adminRole: json['adminRole'] as String?,
      claimsUpdatedAt: json['claimsUpdatedAt'] != null
          ? DateTime.parse(json['claimsUpdatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAdmin': isAdmin,
      'adminRole': adminRole,
      'claimsUpdatedAt': claimsUpdatedAt?.toIso8601String(),
    };
  }

  factory AdminClaimsModel.fromTokenClaims(Map<String, dynamic>? claims) {
    if (claims == null) return const AdminClaimsModel();
    
    return AdminClaimsModel(
      isAdmin: claims['admin'] == true,
      adminRole: claims['adminRole'] as String?,
      claimsUpdatedAt: DateTime.now(),
    );
  }

  AdminClaimsModel copyWith({
    bool? isAdmin,
    String? adminRole,
    DateTime? claimsUpdatedAt,
  }) {
    return AdminClaimsModel(
      isAdmin: isAdmin ?? this.isAdmin,
      adminRole: adminRole ?? this.adminRole,
      claimsUpdatedAt: claimsUpdatedAt ?? this.claimsUpdatedAt,
    );
  }
}
