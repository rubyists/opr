# frozen_string_literal: true

require_relative '../command'

module Rubyists
  module Opr
    module Commands
      class Get < Rubyists::Opr::Command
        def initialize(item, options)
          @item = item
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          vault = if options[:vault]
                    options[:vault]
                  else
                    warn 'No vault specified, using "Private"'
                    'Private'
                  end
          Opr.with_login { output.puts Item.find(@item, vault: vault) }
        end
      end
    end
  end
end
