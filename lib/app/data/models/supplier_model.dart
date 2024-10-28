class Supplier {
  final String name;
  final String imageUrl;
  final double rating;
  final String type;
  final String specialism;
  final List<String> tags;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String email;
  final String address;
  final List<String> certifications;
  final List<String> awards;
  final String history;
  final String mission;
  final List<String> userGeneratedContent;
  final bool hasLiveChat;
  final bool hasCalendar;
  final bool hasSampleRequest;
  final bool hasQuoteRequest;
  final bool hasLoyaltyProgram;

  Supplier({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.type,
    required this.specialism,
    required this.tags,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.certifications,
    required this.awards,
    required this.history,
    required this.mission,
    required this.userGeneratedContent,
    required this.hasLiveChat,
    required this.hasCalendar,
    required this.hasSampleRequest,
    required this.hasQuoteRequest,
    required this.hasLoyaltyProgram,
  });
}
