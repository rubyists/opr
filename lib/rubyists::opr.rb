require 'rubyists::opr/version' # rubocop:disable Naming/FileName
require 'pathname'

module Rubyists
  # Main namespace
  module Opr
    class Error < StandardError; end
    ROOT = Pathname(__FILE__).dirname.expand_path.join('..').expand_path
    LIBDIR = ROOT.join('lib/rubyists::opr')
    MODEL_DIR = LIBDIR.join('model')

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
