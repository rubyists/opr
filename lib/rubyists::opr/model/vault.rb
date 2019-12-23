require 'tty-command'
module Rubyists
  module Opr
    # Represents a 1password vault
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

      def self.find_by_name(name)
        all.detect { |n| n.name == name }
      end

      attr_reader :name, :uuid
      def initialize(uuid:, name:)
        @name = name
        @uuid = uuid
      end

      def insert(name:, password:, type: 'login', username: nil, notes: nil)
        current = Item.find(name, vault: self.name)
        raise "There is already an item named #{name} in the #{self.name} vault" if current

        tpl = Opr::LIBDIR.join("commands/templates/gen/#{type}.erb")
        erb = ERB.new(tpl.read)
        hash = JSON.parse erb.result(binding)
        Item.create!(hash, vault: uuid, name: name)
      end

      def items
        return @items if @items

        cmd = TTY::Command.new pty: true, printer: :null
        out, err = cmd.run "#{Opr.opbin} list items --vault='#{name}'"
        array = JSON.parse out
        @items = array.map { |h| Item.from_hash h }
      end
    end
  end
end
