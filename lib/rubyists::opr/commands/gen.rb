# frozen_string_literal: true

require_relative '../command'

module Rubyists
  module Opr
    module Commands
      class Gen < Rubyists::Opr::Command
        def initialize(options)
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          # Command logic goes here ...
          output.puts "OK"
        end
      end
    end
  end
end
