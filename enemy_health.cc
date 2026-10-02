#include "enemy_health.h"

EnemyHealth:: EnemyHealth(int max_health)
    : max_health_(max_health), current_health_(max_health) {}
    void EnemyHealth::TakeDamage(int damage) {
        if (damage <= 0) {
            return;
        }
        current_health_ -=damage;

        if (current_health_ <0) {
            current_health_=0;
        }
    } 
    int EnemyHealth ::GetCurrentHealth() const {
        return current_health_;
    }
    int EnemyHealth::GetMaxHealth() const{
        return max_health_;
    }