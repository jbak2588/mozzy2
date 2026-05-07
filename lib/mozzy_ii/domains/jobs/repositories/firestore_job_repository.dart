import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_post_model.dart';
import '../models/job_applicant_model.dart';
import 'job_repository.dart';

class FirestoreJobRepository implements JobRepository {
  final FirebaseFirestore _firestore;

  FirestoreJobRepository(this._firestore);

  CollectionReference get _jobsRef => _firestore.collection('job_posts');

  @override
  Stream<List<JobPostModel>> watchNearbyJobs({
    required String kecamatan,
    String? category,
    JobType? jobType,
  }) {
    Query query = _jobsRef
        .where('locationParts.idAddress.kecamatan', isEqualTo: kecamatan)
        .where('isDeleted', isEqualTo: false)
        .where('status', isEqualTo: 'open');

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (jobType != null) {
      query = query.where('jobType', isEqualTo: jobType.name);
    }

    return query
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobPostModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    });
  }

  @override
  Future<List<JobPostModel>> fetchJobsByKecamatan({
    required String kecamatan,
    String? category,
    JobType? jobType,
  }) async {
    Query query = _jobsRef
        .where('locationParts.idAddress.kecamatan', isEqualTo: kecamatan)
        .where('isDeleted', isEqualTo: false)
        .where('status', isEqualTo: 'open');

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }
    if (jobType != null) {
      query = query.where('jobType', isEqualTo: jobType.name);
    }

    final snapshot = await query.orderBy('createdAt', descending: true).limit(50).get();

    return snapshot.docs.map((doc) {
      return JobPostModel.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      });
    }).toList();
  }

  @override
  Future<JobPostModel?> fetchJobById(String jobId) async {
    final doc = await _jobsRef.doc(jobId).get();
    if (!doc.exists) return null;
    return JobPostModel.fromJson({
      ...doc.data() as Map<String, dynamic>,
      'id': doc.id,
    });
  }

  @override
  Future<String> createJob(JobPostModel job) async {
    final docRef = await _jobsRef.add(job.toJson());
    return docRef.id;
  }

  @override
  Future<void> updateJob(String jobId, Map<String, dynamic> updates) {
    return _jobsRef.doc(jobId).update({
      ...updates,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> archiveJob(String jobId) {
    return updateJob(jobId, {
      'status': 'archived',
    });
  }

  @override
  Future<void> closeJob(String jobId) {
    return updateJob(jobId, {
      'status': 'closed',
      'isClosed': true,
    });
  }

  @override
  Future<void> incrementViewCount(String jobId) {
    return _jobsRef.doc(jobId).update({
      'viewCount': FieldValue.increment(1),
    });
  }

  @override
  Future<void> incrementChatCount(String jobId) {
    return _jobsRef.doc(jobId).update({
      'chatCount': FieldValue.increment(1),
    });
  }

  @override
  Stream<JobPostModel?> watchJobById(String jobId) {
    return _jobsRef.doc(jobId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return JobPostModel.fromJson({
        ...snapshot.data() as Map<String, dynamic>,
        'id': snapshot.id,
      });
    });
  }

  @override
  Stream<List<JobPostModel>> watchOwnerJobs(String ownerId, {JobPostStatus? status}) {
    Query query = _jobsRef
        .where('ownerId', isEqualTo: ownerId)
        .where('isDeleted', isEqualTo: false);

    if (status != null) {
      query = query.where('status', isEqualTo: status.name);
    }

    return query
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobPostModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    });
  }

  @override
  Future<void> restoreJob(String jobId) {
    return updateJob(jobId, {
      'status': 'open',
      'isClosed': false,
    });
  }

  @override
  Stream<List<JobApplicantModel>> watchApplicants(String jobId, {JobApplicantStatus? status}) {
    Query query = _jobsRef.doc(jobId).collection('applicants');
    
    if (status != null) {
      query = query.where('status', isEqualTo: status.name);
    }
    
    return query
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return JobApplicantModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    });
  }

  @override
  Future<JobApplicantModel?> fetchApplicant(String jobId, String applicantId) async {
    final doc = await _jobsRef.doc(jobId).collection('applicants').doc(applicantId).get();
    if (!doc.exists) return null;
    return JobApplicantModel.fromJson({
      ...doc.data() as Map<String, dynamic>,
      'id': doc.id,
    });
  }

  @override
  Future<void> updateApplicantStatus(String jobId, String applicantId, JobApplicantStatus status) {
    final statusStr = status.name == 'newApplicant' ? 'new' : status.name;
    return _jobsRef.doc(jobId).collection('applicants').doc(applicantId).update({
      'status': statusStr,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> ensureApplicantRecord({
    required JobPostModel job,
    required String applicantId,
    required String applicantName,
    required String chatRoomId,
    String? applicantPhotoUrl,
  }) async {
    final applicantRef = _jobsRef.doc(job.id).collection('applicants').doc(applicantId);
    
    final doc = await applicantRef.get();
    if (doc.exists) {
      // Just update chatRoomId if missing and updatedAt
      await applicantRef.update({
        'chatRoomId': chatRoomId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return;
    }

    await _firestore.runTransaction((transaction) async {
      final applicantDoc = await transaction.get(applicantRef);
      if (applicantDoc.exists) return;

      final jobRef = _jobsRef.doc(job.id);
      
      transaction.set(applicantRef, {
        'id': applicantId,
        'jobId': job.id,
        'applicantId': applicantId,
        'applicantName': applicantName,
        'applicantPhotoUrl': applicantPhotoUrl,
        'chatRoomId': chatRoomId,
        'status': 'new',
        'source': 'job_detail',
        'countryCode': 'ID',
        'appliedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      transaction.update(jobRef, {
        'applicantCount': FieldValue.increment(1),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> incrementApplicantCountOnce(String jobId, String applicantId) async {
    // Deprecated in favor of ensureApplicantRecord, but keeping for compatibility if needed
    final applicantRef = _jobsRef.doc(jobId).collection('applicants').doc(applicantId);
    final doc = await applicantRef.get();
    if (doc.exists) return;

    await _firestore.runTransaction((transaction) async {
      final applicantDoc = await transaction.get(applicantRef);
      if (applicantDoc.exists) return;
      final jobRef = _jobsRef.doc(jobId);
      transaction.set(applicantRef, {'appliedAt': FieldValue.serverTimestamp()});
      transaction.update(jobRef, {
        'applicantCount': FieldValue.increment(1),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }
}
