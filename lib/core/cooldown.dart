import 'dart:collection';

class CooldownEntry {
  final DateTime end;
  CooldownEntry(this.end);

  bool get isExpired => DateTime.now().isAfter(end);
  double get remaining => end.difference(DateTime.now()).inMilliseconds / 1000;
}

class CooldownManager {
  final HashMap<String, HashMap<String, CooldownEntry>> _cooldowns = HashMap();

  bool isOnCooldown(String userId, String command) {
    _cleanup(userId);
    final userCooldowns = _cooldowns[userId];
    if (userCooldowns == null) return false;
    final entry = userCooldowns[command];
    return entry != null && !entry.isExpired;
  }

  double getRemaining(String userId, String command) {
    final userCooldowns = _cooldowns[userId];
    if (userCooldowns == null) return 0;
    final entry = userCooldowns[command];
    if (entry == null || entry.isExpired) return 0;
    return entry.remaining;
  }

  void set(String userId, String command, int seconds) {
    _cooldowns.putIfAbsent(userId, () => HashMap());
    _cooldowns[userId]![command] = CooldownEntry(
      DateTime.now().add(Duration(seconds: seconds)),
    );
  }

  void _cleanup(String userId) {
    final userCooldowns = _cooldowns[userId];
    if (userCooldowns == null) return;
    userCooldowns.removeWhere((_, entry) => entry.isExpired);
    if (userCooldowns.isEmpty) {
      _cooldowns.remove(userId);
    }
  }
}
