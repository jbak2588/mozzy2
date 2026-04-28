import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/repositories/post_repository.dart';

void main() {
  test('postsCollectionPath builds expected path', () {
    final path =
        'countries/${PostRepository.countryId}/domains/${PostRepository.domainId}/posts';
    expect(path, equals('countries/ID/domains/local_news/posts'));
  });
}
