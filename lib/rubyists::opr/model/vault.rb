require 'tty-command'
module Rubyists
  module Opr
    class Vault
      def self.from_output(string)
        from_hash JSON.parse(string)
      end

      def self.from_hash(hash)
        new uuid: hash['uuid'], name: hash['name']
      end

      def self.all
        cmd = TTY::Command.new pty: true, printer: :null
        out, err = cmd.run Opr.opbin, 'list', 'vaults'
        vaults = JSON.parse out
        vaults.map { |v| from_hash v }
      end

      attr_reader :name, :uuid
      def initialize(uuid:, name:)
        @name = name
        @uuid = uuid
      end

      def items
        return @items if @items

        cmd = TTY::Command.new pty: true, printer: :null
        out, err = cmd.run "#{Opr.opbin} list items --vault='#{name}'"
        @items = Item.from_output out
      end
    end
  end
end
