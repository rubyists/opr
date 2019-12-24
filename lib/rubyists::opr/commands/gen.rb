# frozen_string_literal: true

require_relative '../../rubyists::opr'

module Rubyists
  # Main namespace
  module Opr
    L :command
    L :utils
    module Commands
      # Generate passwords
      class Gen < Rubyists::Opr::Command
        attr_reader :path_name
        def initialize(path, options)
          @path_name = path
          @options = options
        end

        # Here we determine if the @path contains a vault
        # or is just a name.
        def parse_path
          # If options[:vault] is supplied, consider the whole @path the item name
          return OpenStruct.new(vault: options[:vault], name: path_name) if options[:vault]

          # Otherwise see if the path starts with a vault
          parts = path_name.split('/', 2)
          # If we got 2 parts, the first is the vault, the rest is the item name
          if parts.size == 2
            vault, name = parts
          else
            name = path_name
            vault = options[:vault] || 'Private'
          end
          OpenStruct.new vault: vault, name: name
        end

        def output_or_save(pass, output: $stdout)
          return output.puts(pass) if path_name.nil?

          parsed = parse_path
          Opr.with_login do
            vault = Vault.find_by_name(parsed.vault)
            vault.insert(title: parsed.name, type: :login, password: pass,
                         username: options[:username], notes: options[:notes])
          end
          output.puts "#{parsed.name} saved in #{parsed.vault}"
        end

        def execute(input: $stdin, output: $stdout)
          chars = begin
                    str = input.read_nonblock(1) << input.read.chomp
                    str.chars
                  rescue IO::EAGAINWaitReadable
                    Opr::Utils::SAMPLES
                  end
          chars = nil if options[:chars] == false
          if options[:size]
            min = max = options[:size]
          else
            min, max = options.values_at :min, :max
          end
          output_or_save Utils.passgen(min, max, chars), output: output
        end
      end
    end
  end
end
