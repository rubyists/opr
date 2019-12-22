RSpec.describe "`rubyists::opr list` command", type: :cli do
  it "executes `rubyists::opr help list` command successfully" do
    output = `rubyists::opr help list`
    expected_output = <<-OUT
Commands:
    OUT

    expect(output).to eq(expected_output)
  end
end
