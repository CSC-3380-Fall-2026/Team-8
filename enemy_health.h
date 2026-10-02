#ifndef ENEMY_HEALTH_H_
#define ENEMY_HEALTH_H_

class EnemyHealth {
    public :
    explicit EnemyHealth(int max_health);

    void TakeDamage(int damage);
    
    int GetCurrentHealth() const;
    int GetMaxHealth() const;

    private: 
    int max_health_;
    int current_health_;
};
#endif 
