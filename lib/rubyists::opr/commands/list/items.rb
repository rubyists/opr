# frozen_string_literal: true

require_relative '../../command'

module Rubyists
  module Opr
    module Commands
      class List
        # Items subcommand
        class Items < Rubyists::Opr::Command
          attr_reader :vault
          def initialize(vault, options)
            @vault = vault
            @options = options
          end

          def execute(input: $stdin, output: $stdout) # rubocop:disable Lint/UnusedMethodArgument
            if vault.nil?
              warn 'Using vault "Private" since none was given'
              @vault = 'Private'
            end
            # Command logic goes here ...
            Opr.with_login { output.puts Vault.find_by_name(vault).items.map(&:title) }
          end
        end
      end
    end
  end
end
