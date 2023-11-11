class AccountModel {
  const AccountModel({ required this.email, required this.displayName });

  final String email;
  final String? displayName;

  String getDisplayInfo() 
    => displayName != null && displayName!.isNotEmpty ? displayName! : email;
}