require 'spec_helper'

RSpec.describe 'space_after_comma' do
  let(:message) { 'Add space after the comma' }

  context 'with missing space after single comma' do
    let(:code) { "'vivid','wily'" }

    it { expect(problems).to contain_warning(message).on_line(1).in_column(8) }
  end

  context 'with missing space after two commas' do
    let(:code) { "'vivid','wily', 'xenial','yakketi'" }

    it { expect(problems).to have(2).problems }
    it { expect(problems).to contain_warning(message).on_line(1).in_column(8) }
    it { expect(problems).to contain_warning(message).on_line(1).in_column(25) }
  end

  context 'with space after comma' do
    let(:code) { "'vivid', 'wily'" }

    it { expect(problems).to have(0).problems }
  end

  context 'with trailing comma' do
    let(:code) { "'vivid', 'wily'," }

    it { expect(problems).to have(0).problems }
  end

  context 'with new line after comma' do
    let(:code) { "'vivid',\n'wily',\n'xenial'" }

    it { expect(problems).to have(0).problems }
  end

  context 'with semicolon after comma' do
    let(:code) { "'vivid', 'wily', 'xenial',;" }

    it { expect(problems).to have(0).problems }
  end

  context 'with missing comma after the last element of a list' do
    let(:code) { "['vivid', 'wily', 'xenial',]" }

    it { expect(problems).to have(0).problems }
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    let(:code) { "'vivid','wily', 'xenial','yakketi'" }
    let(:fixed) { "'vivid', 'wily', 'xenial', 'yakketi'" }

    it { expect(manifest).to eq(fixed) }
  end
end
