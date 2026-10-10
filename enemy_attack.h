#ifndef ENEMY_ATTACK_H_
#define ENEMY_ATTACK_H_

#include "player_health.h"

class EnemyAttack {
 public:
  explicit EnemyAttack(int damage);

  void Attack(Health& target);

 private:
  int damage_;
};

#endif  // ENEMY_ATTACK_H_