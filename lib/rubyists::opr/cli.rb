# frozen_string_literal: true

require 'thor'

module Rubyists
  module Opr
    # Handle the application command line parsing
    # and the dispatch to various command objects
    #
    # @api public
    class CLI < Thor
      # Error raised by this runner
      Error = Class.new(StandardError)

      desc 'version', 'rubyists::opr version'
      def version
        require_relative 'version'
        puts "v#{Rubyists::Opr::VERSION}"
      end
      map %w[--version -v] => :version

      desc 'gen', 'Command description...'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def gen(*)
        if options[:help]
          invoke :help, ['gen']
        else
          require_relative 'commands/gen'
          Rubyists::Opr::Commands::Gen.new(options).execute
        end
      end
    end
  end
end
