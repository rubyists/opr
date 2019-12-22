# frozen_string_literal: true

require 'thor'

module Rubyists
  # Main namespace
  module Opr
    M :vault
    M :item
    module Commands
      # List commands
      class List < Thor

        namespace :list

        desc 'items', 'Command description...'
        method_option :help, aliases: '-h', type: :boolean,
                             desc: 'Display usage information'
        def items(vault = nil)
          if options[:help]
            invoke :help, ['items']
          else
            require_relative 'list/items'
            Rubyists::Opr::Commands::List::Items.new(vault, options).execute
          end
        end

        desc 'vaults', 'Command description...'
        method_option :help, aliases: '-h', type: :boolean,
                             desc: 'Display usage information'
        def vaults(*)
          if options[:help]
            invoke :help, ['vaults']
          else
            require_relative 'list/vaults'
            Rubyists::Opr::Commands::List::Vaults.new(options).execute
          end
        end
      end
    end
  end
end
