require 'rubyists::opr/commands/list/items'

RSpec.describe Rubyists::Opr::Commands::List::Items do
  it 'executes `list items` command successfully' do
    output = StringIO.new
    vault = nil
    options = {}
    command = Rubyists::Opr::Commands::List::Items.new(vault, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
