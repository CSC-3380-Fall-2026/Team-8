// This is our basic health script for the characters.
#ifndef PLAYER_HEALTH_H_
#define PLAYER_HEALTH_H_

class Health {
 public:
  explicit Health(int max_health);

  void TakeDamage(int damage);
  void Heal(int amount);

  int GetCurrentHealth() const;
  int GetMaxHealth() const;

  bool IsDead() const;

 private:
  int max_health_;
  int current_health_;
};

#endif  // PLAYER_HEALTH_H_
// This is pretty much just defines the health class