# frozen_string_literal: true

require_relative '../command'

module Rubyists
  module Opr
    module Commands
      # 'get' command
      class Get < Rubyists::Opr::Command
        def initialize(item, options)
          @item = item
          @options = options
        end

        def execute(input: $stdin, output: $stdout) # rubocop:disable Lint/UnusedMethodArgument
          if options[:vault]
            vault = options[:vault]
          else
            split = @item.split('/', 2)
            vault, @item = split if split.size == 2
          end
          if vault.nil?
            warn 'No vault specified, using "Private"'
            vault = 'Private'
          end
          Opr.with_login { output.puts Item.find(@item, vault: vault) }
        end
      end
    end
  end
end
