# frozen_string_literal: true

require 'thor'

module Rubyists
  module Opr
    module Commands
      class List < Thor

        namespace :list

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
