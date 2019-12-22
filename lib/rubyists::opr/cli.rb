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

      def self.exit_on_failure?
        true
      end

      desc 'version', 'rubyists::opr version'
      def version
        require_relative 'version'
        puts "v#{Rubyists::Opr::VERSION}"
      end
      map %w[--version -v] => :version

      require_relative 'commands/list'
      register Rubyists::Opr::Commands::List, 'list', 'list [SUBCOMMAND]', 'Command description...'

      desc 'gen [vault/path]', 'Generate a new password, optionally saving it in a vaule'
      method_option :min, type: :numeric, desc: 'Minimum Pass size', default: 8, aliases: ['-m']
      method_option :max, type: :numeric, desc: 'Maximum Pass size', aliases: ['-M']
      method_option :size, type: :numeric, desc: 'Exact Pass size', aliases: ['-s']
      method_option :chars, type: :boolean, desc: 'Use Special Chars'

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
