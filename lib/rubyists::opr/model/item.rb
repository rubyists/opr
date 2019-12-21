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

      attr_reader :name, :uuid
      def initialize(uuid:, name:, raw:)
        @name = name
        @uuid = uuid
        @raw  = raw
        parse_raw
      end

      def inspect
        "<#{self.class}:#{object_id} name: #{name} uuid: #{uuid}>"
      end

      def parse_raw
        @raw.keys.each do |k|
          define_method k.to_sym do
            @raw[k]
            if @raw[k].respond_to? key?
              @raw[k].keys.each do |key|
                define_method key.to_sym do
                  raw[k][key]
                end
              end
            end
          end
        end
      end
    end
  end
end
