import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/repositories/firestore_job_repository.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_applicant_model.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<Query>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<DocumentSnapshot>(),
])
import 'job_applicant_repository_test.mocks.dart';

void main() {
  late FirestoreJobRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockJobsCollection;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockJobsCollection = MockCollectionReference<Map<String, dynamic>>();
    
    when(mockFirestore.collection('job_posts')).thenReturn(mockJobsCollection);
    
    repository = FirestoreJobRepository(mockFirestore);
  });

  group('FirestoreJobRepository - Applicants', () {
    test('updateApplicantStatus should call update with correct data', () async {
      final mockJobDoc = MockDocumentReference<Map<String, dynamic>>();
      final mockApplicantsCol = MockCollectionReference<Map<String, dynamic>>();
      final mockApplicantDoc = MockDocumentReference<Map<String, dynamic>>();

      when(mockJobsCollection.doc('job1')).thenReturn(mockJobDoc);
      when(mockJobDoc.collection('applicants')).thenReturn(mockApplicantsCol);
      when(mockApplicantsCol.doc('user1')).thenReturn(mockApplicantDoc);

      await repository.updateApplicantStatus('job1', 'user1', JobApplicantStatus.shortlisted);

      verify(mockApplicantDoc.update(argThat(containsPair('status', 'shortlisted')))).called(1);
    });
  });
}
