#!/usr/bin/env ruby


require 'pry'
require_relative "rake_flow_visualizer/task.rb"



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
  
end

input = ""
while true
  begin
    char = STDIN.sysread(1)
    input += char
  rescue EOFError
    break
  end
end

RakeFlowVisualizer.parse(input)
