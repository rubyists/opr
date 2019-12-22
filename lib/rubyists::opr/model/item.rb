module Rubyists
  module Opr
    # An item
    class Item
      def self.from_output(string)
        from_hash JSON.parse(string)
      end

      def self.from_hash(hash)
        new uuid: hash['uuid'], name: hash['overview']['title'], raw: hash
      end

      def self.find(item, vault:)
        cmd = TTY::Command.new pty: true, printer: :null
        out, err = cmd.run "#{Opr.opbin} get item #{item} --vault='#{vault}'"
        raise Error, err unless err.empty?

        item = from_output out
        item.password
      end

      attr_reader :name, :uuid, :raw
      def initialize(uuid:, name:, raw:)
        @name = name
        @uuid = uuid
        @raw  = raw
      end

      def password
        pass_field = @raw['details']['fields'].detect { |f| f['designation'] == 'password' }
        pass_field['value']
      end

      def title
        @title ||= raw['overview']['title']
      end

      def inspect
        "<#{self.class}:#{object_id} name: #{name} uuid: #{uuid}>"
      end
    end
  end
end
