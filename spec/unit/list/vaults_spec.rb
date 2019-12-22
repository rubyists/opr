require 'rubyists::opr/commands/list/vaults'

RSpec.describe Rubyists::Opr::Commands::List::Vaults do
  it "executes `list vaults` command successfully" do
    output = StringIO.new
    options = {}
    command = Rubyists::Opr::Commands::List::Vaults.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
