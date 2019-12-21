module Rubyists # rubocop:disable Naming/FileName
  module Opr
    L :command
    RSpec.describe Opr do
      context 'opr library' do
        it 'has a version number' do
          expect(Opr::VERSION).not_to be nil
        end
      end

      context '`op` binary' do
        it 'exists' do
          expect(Opr.opbin.empty?).to be false
          expect(Pathname(Opr.opbin).exist?).to be true
        end
        it 'is executable' do
          expect(Pathname(Opr.opbin).executable?).to be true
        end
      end
    end
  end
end
