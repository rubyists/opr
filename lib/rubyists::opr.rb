require 'rubyists::opr/version' # rubocop:disable Naming/FileName
require 'pathname'

module Rubyists
  # Main namespace
  module Opr
    class Error < StandardError; end
    ROOT = Pathname(__FILE__).dirname.expand_path.join('..').expand_path
    LIBDIR = ROOT.join('lib/rubyists::opr')
    MODEL_DIR = LIBDIR.join('model')

    def self.with_login
      yield
    rescue TTY::Command::ExitError => e
      raise unless e.to_s.match?(/not currently signed in|401: Authentication/)

      warn 'You are not currently logged in to 1pass'
      warn 'Consider running `eval (op signin)` in your shell to avoid logging in for each opr command'
      Opr.login!
      retry
    end

    def self.login!
      out = `#{opbin} signin 2>&1`
      raise "Problem logging in #{out}" if out.match? '(ERROR)'

      firstline = out.split("\n").first.split('=')
      key = firstline.first.split.last
      val = JSON.parse(firstline.last)
      ENV[key] = val
    end

    def self.opbin(bin_name: 'op')
      raise Error, 'attribute bin_name cannot be nil' if bin_name.empty?

      @opbin ||= `which #{bin_name}`.chomp
      raise Error, '`op` binary not found' if @opbin.empty?

      @opbin
    end

    def self.R(rbf) # rubocop:disable Naming/MethodName
      require ROOT.join(rbf.to_s).to_s
    end

    def self.L(lib) # rubocop:disable Naming/MethodName
      require LIBDIR.join(lib.to_s).to_s
    end

    def self.M(model) # rubocop:disable Naming/MethodName
      require MODEL_DIR.join(model.to_s).to_s
    end
  end
end
