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

      def self.create(hash, title, vault = 'Private', type: :login)
        cmd = TTY::Command.new pty: true, printer: :null

        Opr.with_login do
          cmd.run "#{Opr.opbin} create item '#{type.capitalize}' '#{hash}' --vault='#{vault}' --title='#{title}'"
        end
      end

      def self.find(item, vault:)
        cmd = TTY::Command.new pty: true, printer: :null
        out, err = Opr.with_login do
          cmd.run "#{Opr.opbin} get item '#{item}' --vault='#{vault}'"
        end
        raise Error, err unless err.empty?

        from_output out
      rescue TTY::Command::ExitError => e
        return nil if e.to_s.match?(/item with query "#{Regexp.escape(item)}" not found/)

        raise
      end

      attr_reader :name, :uuid, :raw
      def initialize(uuid:, name:, raw:)
        @name = name
        @uuid = uuid
        @raw  = raw
      end

      def vault_uuid
        @vault_uuid ||= raw['vaultUuid']
      end

      def delete!
        Opr.with_login do
          cmd = TTY::Command.new pty: true, printer: :null
          cmd.run "#{Opr.opbin} delete item '#{name}' --vault='#{vault_uuid}'"
        end
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
