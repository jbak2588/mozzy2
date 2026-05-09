enum FeedInteractionType {
  impression,
  cardTap,
  detailOpen,
  ctaTap;

  String get wireValue {
    switch (this) {
      case FeedInteractionType.impression:
        return 'impression';
      case FeedInteractionType.cardTap:
        return 'card_tap';
      case FeedInteractionType.detailOpen:
        return 'detail_open';
      case FeedInteractionType.ctaTap:
        return 'cta_tap';
    }
  }
}
