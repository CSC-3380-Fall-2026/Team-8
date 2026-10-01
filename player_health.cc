#include "player_health.h"

Health::Health(int max_health)
    : max_health_(max_health), current_health_(max_health) {}

void Health::TakeDamage(int damage) {
  if (damage <= 0) {
    return;
  }

  current_health_ -= damage;

  if (current_health_ < 0) {
    current_health_ = 0;
  }
}

void Health::Heal(int amount) {
  if (amount <= 0) {
    return;
  }

  current_health_ += amount;

  if (current_health_ > max_health_) {
    current_health_ = max_health_;
  }
}

int Health::GetCurrentHealth() const {
  return current_health_;
}

int Health::GetMaxHealth() const {
  return max_health_;
}

bool Health::IsDead() const {
  return current_health_ == 0;
}
//how the health actually works