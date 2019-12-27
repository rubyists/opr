RSpec.describe '`rubyists::opr list items` command', type: :cli do
  it 'executes `rubyists::opr list help items` command successfully' do
    output = `rubyists::opr list help items`
    expected_output = <<~OUT
      Usage:
        rubyists::opr items [VAULT]

      Options:
        -h, [--help], [--no-help]  # Display usage information

      Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
