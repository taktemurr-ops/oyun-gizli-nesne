import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_gizli_nesne/oyun_gizli_nesne.dart';
import 'package:eslestirme_motoru/eslestirme_motoru.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(gizliConfig.title.length, 33);
    expect(gizliConfig.tagline.length, 33);
    for (final s in gizliConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: gizliId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = gizliRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      expect(MLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
      final g = gizliRules.kindForLevel(gl.spec.difficulty).start(gl.puzzle);
      expect(g.save(), isNotEmpty);
    }
  });
}
