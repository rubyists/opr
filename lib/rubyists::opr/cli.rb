# frozen_string_literal: true

require_relative '../rubyists::opr'
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

      desc 'rm ITEM', 'Remove an item from a vault'
      method_option :vault, aliases: '-v', type: :string,
                            desc: 'The vault to look for ITEM'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def rm(item)
        if options[:help]
          invoke :help, ['rm']
        else
          require_relative 'commands/rm'
          Rubyists::Opr::Commands::Rm.new(item, options).execute
        end
      end

      desc 'get ITEM', 'Get the contents of an item'
      method_option :vault, aliases: '-v', type: :string, desc: 'Which vault the item is in'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def get(item)
        if options[:help]
          invoke :help, ['get']
        else
          require_relative 'commands/get'
          Rubyists::Opr::Commands::Get.new(item, options).execute
        end
      end

      require_relative 'commands/list'
      register Rubyists::Opr::Commands::List, 'list', 'list [SUBCOMMAND]', 'List items/vaults'

      desc 'gen [NAME | VAULT/NAME]',
           <<~TXT
             Generate a new password. If NAME or VAULT/NAME is given, store the generated pass, otherwise output it.
             if STDIN is passed, will use those characters as the special characters.
           TXT
      method_option :min, type: :numeric, desc: 'Minimum Pass size', default: 8, aliases: ['-m']
      method_option :max, type: :numeric, desc: 'Maximum Pass size', aliases: ['-M']
      method_option :size, type: :numeric, desc: 'Exact Pass size', aliases: ['-s']
      method_option :chars, type: :boolean, desc: '(Do not) Use Special Chars', default: true
      method_option :vault, type: :string, desc: 'Vault to save password in', default: 'Private'
      method_option :type, type: :string, enum: %w[login note], default: 'login',
                           desc: 'The type of item to store'

      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def gen(path = nil)
        if options[:help]
          invoke :help, ['gen']
        else
          require_relative 'commands/gen'
          Rubyists::Opr::Commands::Gen.new(path, options).execute
        end
      end
    end
  end
end
