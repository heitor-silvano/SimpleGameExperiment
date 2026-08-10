class PlayerJob
  attr_accessor :name, :job, :life_quantity, :damage, :area, :level, :fight_options, :total_life

  def initialize(name, job)
    @name = name
    @job = job
    @life_quantity = life_by_job(job)
    @total_life = life_by_job(job)
    @damage = damage_by_job(job)
    @area = :village
    @level = 0
    @fight_options = fight_options_by_job(job)
  end

  private

  def damage_by_job(job)
    { "Guerreiro" => 15, "Mago" => 20, "Ladrão" => 10, "Arqueiro" => 10 } [job]
  end

  def life_by_job(job)
    { "Guerreiro" => 150, "Mago" => 80, "Ladrão" => 90, "Arqueiro" => 100 } [job]
  end

  def fight_options_by_job(job)
    {
      "Guerreiro" => [{ title: "Ataque leve", damage: 15 }, { title: "Ataque pesado", damage: 22 }, { title: "Porrada", damage: 8 }],
      "Mago" => [{ title: "Orb de energia", damage: 18 }, { title: "Cajadada", damage: 3 }],
      "Ladrão" => [{ title: "Facadas duplas", damage: 13 }, { title: "Arremessar estrelas", damage: 18 }, { title: "Chutes", damage: 6 }],
      "Arqueiro" => [{ title: "Atirar", damage: 16 }, { title: "Tiro duplo", damage: 19 }, { title: "Arqueada", damage: 5 }]
    }[job]
  end
end