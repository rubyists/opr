require 'securerandom'
require 'base64'

module Rubyists # {{{
  # Main namespace
  module Opr # {{{
    def self.s_or_no(count) # {{{
      count == 1 ? '' : 's'
    end # }}}

    # Utility methods
    module Utils # {{{
      Doofus = Class.new Opr::Error
      MAX_PASS_SIZE = 8192
      SAMPLES = ((' '..'@').to_a + ('['..'`').to_a + ('{'..'~').to_a).freeze

      def self.decode(str) # {{{
        Base64.decode64(str)
      end # }}}

      def self.encode(obj) # {{{
        doofus! "#{obj} does not respond to #to_json" unless obj.respond_to? :to_json

        Base64.encode64(obj.to_json).tr("\n", '').sub(/=+$/, '')
      end # }}}

      def self.doofus!(message, code: 1) # {{{
        raise Doofus, message
      rescue Doofus => e
        warn "Doofus Error! <<#{e}>>"
        exit code
      end # }}}

      def self.chunk_size(size) # {{{
        if size > 20
          4..6
        elsif size > 12
          3..5
        elsif size > 8
          2..4
        else
          1..3
        end.to_a
      end # }}}

      def self.shuffle_and_right_size(arr, size) # {{{
        arr.flatten.sort { |_, _| rand(10) >= 5 ? 1 : -1 }.join('')[0, size]
      end # }}}

      # Generate a (non-url-safe) password
      def self.passgen(minsize, maxsize = nil, chars = SAMPLES) # {{{
        doofus! "What's the point in a #{minsize} character pass? Minimum is 6" if minsize < 6
        maxsize ||= 16
        doofus! "You're going to break something with a max size of #{maxsize} Max is #{MAX_PASS_SIZE}" if maxsize > MAX_PASS_SIZE # rubocop:disable Metrics/LineLength

        maxsize = minsize if minsize > maxsize
        size = (minsize..maxsize).to_a.sample
        chunks = chunk_size size
        arr = SecureRandom.base64(size).sub(/=+$/, '').chars.each_slice(chunks.sample).map do |e|
          e.join << chars.sample
        end
        shuffle_and_right_size arr, size
      end # }}}
    end # }}}
  end # }}}
end # }}}
# vim: set et sts=2 sw=2 ts=2 syntax=ruby foldmethod=marker:
