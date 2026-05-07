import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('JobPostModel', () {
    final location = LocationParts(
      countryCode: 'ID',
      latitude: -6.2,
      longitude: 106.8,
      geoHash: 'qwerty',
      idAddress: const IndonesiaGeoAddress(
        provinsi: 'Jawa Barat',
        kabupaten: 'Kota Bandung',
        kecamatan: 'Coblong',
        kelurahan: 'Lebak Siliwangi',
      ),
    );

    final job = JobPostModel(
      id: 'job1',
      title: 'Kasir Restoran',
      description: 'Dibutuhkan kasir ramah',
      companyName: 'Warung Sari Rasa',
      ownerId: 'user1',
      ownerName: 'Budi',
      category: 'restaurant',
      jobType: JobType.partTime,
      workType: WorkType.onsite,
      salaryType: SalaryType.daily,
      salaryMin: 100000,
      salaryMax: 150000,
      locationParts: location,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
      expiresAt: DateTime(2026, 2, 1),
    );

    test('should serialize to JSON correctly', () {
      final json = job.toJson();
      expect(json['id'], 'job1');
      expect(json['title'], 'Kasir Restoran');
      expect(json['jobType'], 'partTime');
    });

    test('should generate correct geoPath', () {
      expect(job.geoPath, 'ID#Jawa Barat#Kota Bandung#Coblong#Lebak Siliwangi');
    });

    test('should identify as owner', () {
      expect(job.userId, 'user1');
    });
  });
}
