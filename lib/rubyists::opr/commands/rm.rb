# frozen_string_literal: true

require_relative '../command'

module Rubyists
  module Opr
    # Commands namespace
    module Commands
      # the rm command
      class Rm < Rubyists::Opr::Command
        def initialize(item, options)
          @item = item
          @options = options
        end

        def execute(input: $stdin, output: $stdout) # rubocop:disable Lint/UnusedMethodArgument
          vault_name = if options[:vault]
                         options[:vault]
                       else
                         warn 'No vault given, using "Private"'
                         'Private'
                       end
          Opr.with_login do
            found = Item.find(@item, vault: vault_name)
            return(output.puts("No item '#{@item}' found in vault '#{vault_name}'")) if found.nil?

            found.delete!
            output.puts "Removed '#{@item}' from '#{vault_name}'"
          end
        end
      end
    end
  end
end
