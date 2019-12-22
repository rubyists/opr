# frozen_string_literal: true

require_relative '../../rubyists::opr'

module Rubyists
  # Main namespace
  module Opr
    L :command
    L :utils
    module Commands
      # Generate passwords
      class Gen < Rubyists::Opr::Command
        def initialize(options)
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          # Command logic goes here ...
          chars = begin
                    str = input.read_nonblock(1) << input.read.chomp
                    str.chars
                  rescue IO::EAGAINWaitReadable
                    Opr::Utils::SAMPLES
                  end
          if options[:size]
            min = max = options[:size]
          else
            min, max = options.values_at :min, :max
          end
          output.puts Utils.passgen(min, max, chars)
        end
      end
    end
  end
end
