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
        out, err = Opr.with_login { cmd.run Opr.opbin, 'list', 'vaults' }
        raise "Error #{err}" unless err.nil? || err.empty?

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

      def insert(title:, password:, type: 'login', username: nil, notes: nil)
        current = Item.find(title, vault: name)
        raise "There is already an item named #{title} in the #{name} vault" if current

        tpl = Opr::LIBDIR.join("commands/templates/gen/#{type}.erb")
        erb = ERB.new(tpl.read)
        json = erb.result(binding)
        Item.create(json, title, name, type: :login)
      end

      def items
        return @items if @items

        cmd = TTY::Command.new pty: true, printer: :null
        out, err = Opr.with_login { cmd.run "#{Opr.opbin} list items --vault='#{name}'" }
        raise "Error #{err}" unless err.nil? || err.empty?

        array = JSON.parse out
        @items = array.map { |h| Item.from_hash h }
      end
    end
  end
end
