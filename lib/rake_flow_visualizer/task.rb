module RakeFlowVisualizer
  class Task
  
    def self.find_or_create(name)
      @tasks ||= []
      existing_task = @tasks.find { |task| task.name == name }
      if existing_task
        existing_task
      else
        new_task = new(name)
        @tasks << new_task
        new_task
      end
    end
    
    def self.all
      @tasks ||= []
    end
    
    attr_reader :name, :dependencies
    
    def initialize(name)
      @name = name
      @dependencies = []
    end
    
    def to_s
      @name
    end
    
  end
end
