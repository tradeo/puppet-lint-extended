require 'spec_helper'

RSpec.describe 'space_inside_braces' do
  let(:message_for_opening_brace) { 'Add space after opening brace' }
  let(:message_for_closing_brace) { 'Add space before closing brace' }

  context 'with missing space after opening brace' do
    let(:code) { "if $url {do_something }" }

    it { expect(problems).to contain_warning(message_for_opening_brace).on_line(1).in_column(9) }
  end

  context 'with empty braces' do
    let(:code) { "if $url {}" }

    it { expect(problems).to have(0).problems }
  end

  context 'with new line after opening brace' do
    let(:code) do <<-RUBY
      if $url {

        }
      RUBY
    end

    it { expect(problems).to have(0).problems }
  end

  context 'with missing space before closing brace' do
    let(:code) { "if $url { do_something}" }

    it { expect(problems).to contain_warning(message_for_closing_brace).on_line(1).in_column(23) }
  end


  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    let(:code) { "if $url {do_something}" }
    let(:fixed) { "if $url { do_something }" }

    it { expect(manifest).to eq(fixed) }
  end
end
