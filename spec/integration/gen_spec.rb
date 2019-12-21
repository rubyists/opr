RSpec.describe '`opr gen` command', type: :cli do
  it 'executes `opr help gen` command successfully' do
    output = `rubyists::opr help gen`
    expected_output = <<-OUT
Usage:
  opr gen

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
