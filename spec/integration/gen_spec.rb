RSpec.describe "`rubyists::opr gen` command", type: :cli do
  it "executes `rubyists::opr help gen` command successfully" do
    output = `rubyists::opr help gen`
    expected_output = <<-OUT
Usage:
  rubyists::opr gen

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
