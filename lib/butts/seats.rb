require 'butts/rule'
require 'faker'

module Butts
  class Seats
    attr_reader :cols, :rows, :seats, :students, :rules

    def initialize(cols: 5, rows: 6)
      @cols = cols
      @rows = rows
      @seats = Array.new(@cols) { Array.new(@rows) }
      @students = 30.times.map { Faker::Name.name }
      @rules = []
      @changes = []
    end

    def get((x, y))
      @seats[x][y]
    end

    def set((x, y), value)
      @seats[x][y] = value
    end

    def add_rule(rule, &block)
      @rules << Rule.new(rule, &block)
      self
    end

    def assign
      current = 0

      until current == @rules.length
        rule = @rules[current]

        coords = rule
          .call(self)
          .reject { |(x, y)| @cols > x && @rows > y }
          .reject { |coords| get(coords) }
          .sample

        if coords.nil?
          raise "Too many constraints!"
        end

        if get(coords)
          last, idx = @changes.pop

          if last
            raise "Unsolveable rule!"
          end

          set(last, nil)
          current -= 1
          next
        end

        set(coords, rule.student)
        @changes.push(coords, current)

        current += 1
      end

      self
    end

    def to_s
      seats.map do |row|
        row.map do |student|
          student ? "[#{student}]" : "[]"
        end.join(" ")
      end.join("\n")
    end
  end
end
