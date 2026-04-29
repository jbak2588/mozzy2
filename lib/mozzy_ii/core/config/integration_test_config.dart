class IntegrationTestConfig {
  static const bool enabled =
      bool.fromEnvironment('MOZZY_INTEGRATION_TEST', defaultValue: false);

  static const String testUserId = 'integration-test-user';
}
