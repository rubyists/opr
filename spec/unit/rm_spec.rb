require 'rubyists::opr/commands/rm'

RSpec.describe Rubyists::Opr::Commands::Rm do
  it 'executes `rm` command successfully' do
    output = StringIO.new
    ITEM = nil
    options = {}
    command = Rubyists::Opr::Commands::Rm.new(ITEM, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
