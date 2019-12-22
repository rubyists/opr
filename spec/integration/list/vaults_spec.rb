RSpec.describe "`rubyists::opr list vaults` command", type: :cli do
  it "executes `rubyists::opr list help vaults` command successfully" do
    output = `rubyists::opr list help vaults`
    expected_output = <<-OUT
Usage:
  rubyists::opr vaults

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
