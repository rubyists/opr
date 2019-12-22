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
            # Command logic goes here ...
            puts Vault.all.map(&:name)
          rescue TTY::Command::ExitError => e
            raise unless e.to_s.match? 'not currently signed in'

            warn "You are not currently logged in to 1pass"
            warn "Consider running `eval (op signin)` in your shell to avoid logging in for each opr command"
            Opr.login!
            retry
          end
        end
      end
    end
  end
end
