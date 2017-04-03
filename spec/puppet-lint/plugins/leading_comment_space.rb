require 'spec_helper'

RSpec.describe 'leading_comment_space' do
  let(:message) { 'Add space after #' }

  context 'with missing leading space in the comment' do
    let(:code) { "#this should have a whitespace in the beginning" }

    it { expect(problems).to contain_warning(message).on_line(1).in_column(1) }
  end

  context 'with leading space in the comment' do
    let(:code) { "# this should have a whitespace in the beginning" }

    it { expect(problems).to have(0).problems }
  end

  context 'with only #' do
    let(:code) { "######" }

    it { expect(problems).to have(0).problems }
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    let(:code) { "#this should have a whitespace in the beginning" }
    let(:fixed) { "# this should have a whitespace in the beginning" }

    it { expect(manifest).to eq(fixed) }
  end
end
