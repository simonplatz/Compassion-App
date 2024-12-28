import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/services/visisbility_manager.dart';

void main() {
  group('VisibilityManager Tests', () {
    late VisibilityManager visibilityManager;

    setUp(() {
      visibilityManager = VisibilityManager();
    });

    test('Initial course visibility is empty', () {
      expect(visibilityManager.courseVisibility.isEmpty, true);
    });

    test('updateVisibilityBasedOnAnswers updates visibility based on answers', () {
      visibilityManager.updateVisibilityBasedOnAnswers(
        goal: 'Reducere stress',
        experience: 'Begynder',
        preference: 'Visuel',
      );
      expect(visibilityManager.courseVisibility.isNotEmpty, true);
    });
  });
}