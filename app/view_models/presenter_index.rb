class PresenterIndex

  attr_reader :tasks_ary

  def initialize(tasks_ary: [])
    @tasks_ary = tasks_ary
  end
end
