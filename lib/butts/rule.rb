module Butts
  class Rule
    attr_reader :student, :filter

    def initialize(student, &filter)
      @student = student
      @filter = filter
    end

    def call(butts)
      filter.call(butts)
    end
  end
end
