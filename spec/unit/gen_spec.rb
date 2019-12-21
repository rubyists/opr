require 'rubyists::opr/commands/gen'

RSpec.describe Rubyists::Opr::Commands::Gen do
  it 'executes `gen` command successfully' do
    output = StringIO.new
    options = {}
    command = Rubyists::Opr::Commands::Gen.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
