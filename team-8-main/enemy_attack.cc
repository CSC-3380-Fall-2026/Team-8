#include "enemy_attack.h"

EnemyAttack::EnemyAttack(int damage) : damage_(damage) {}

void EnemyAttack::Attack(Health& target) {
  target.TakeDamage(damage_);
}
// These define what an attack is and how it changes the health of the player. 