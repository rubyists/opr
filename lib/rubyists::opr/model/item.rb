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

      attr_reader :name, :uuid, :raw
      def initialize(uuid:, name:, raw:)
        @name = name
        @uuid = uuid
        @raw  = raw
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
