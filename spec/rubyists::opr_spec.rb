module Rubyists # rubocop:disable Naming/FileName
  module Opr
    L :command
    RSpec.describe Opr do
      it 'has a version number' do
        expect(Opr::VERSION).not_to be nil
      end

      context 'command' do
        it 'Finds the `op` binary' do
          expect(Opr::Command::OPBIN.empty?).to be false
          expect(Pathname(Opr::Command::OPBIN).exist?).to be true
        end
      end
    end
  end
end
