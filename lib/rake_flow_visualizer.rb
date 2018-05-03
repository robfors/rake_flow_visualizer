require 'open3'

require 'rake_flow_visualizer/task'


module RakeFlowVisualizer

  def self.parse(text)
    lines = text.split("\n").map(&:strip)
    parent = nil
    lines.each do |line|
      if line[0..4] == 'rake '
        parent_name = line[5..-1]
        parent = Task.find_or_create(parent_name)
        next
      end
      raise unless parent
      dependency_name = line
      dependency = Task.find_or_create(dependency_name)
      parent.dependencies << dependency
    end
    Task.all.each do |task|
      print_task(0, task, [])
      puts
    end
  end
  
  def self.print_task(depth, task, ignore)
    return if ignore.include?(task)
    ignore << task
    print "|" * depth
    puts task
    task.dependencies.each { |dependency| print_task(depth + 1, dependency, ignore) }
  end
  
  def self.run
    _stdout, status = Open3.capture2('rake --help')
    raise 'can not find rake, is it installed?' unless status.success?
    stdout, status = Open3.capture2('rake -P')
    unless status.success?
      puts stdout
      raise "executing 'rake -P' resulted in an exception"
    end
    puts "--- Rake Flow Visualizer ---"
    puts "The following shows a list for every task that can be run."
    puts "Each list will have the requisites for the task and the order that they will be executed."
    puts
    puts
    parse(stdout)
  end
  
end
