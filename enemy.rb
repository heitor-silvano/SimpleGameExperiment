class Enemy
  attr_accessor :health_points, :title

  def initialize (health_points, title)
    @health_points = health_points
    @title = title
  end
end