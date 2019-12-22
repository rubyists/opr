# frozen_string_literal: true

require_relative '../../command'

module Rubyists
  # Main namespace
  module Opr
    M :vault
    module Commands
      class List
        # List Vaults command
        class Vaults < Rubyists::Opr::Command
          def initialize(options)
            @options = options
          end

          def execute(input: $stdin, output: $stdout) # rubocop:disable Lint/UnusedMethodArgument
            Opr.with_login { output.puts Vault.all.map(&:name) }
          end
        end
      end
    end
  end
end
