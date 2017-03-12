require 'spec_helper'

RSpec.describe 'space_around_operators' do

  shared_examples_for 'missing space' do |operator|
    let(:message) { "Surrounding space missing for operator #{operator}" }

    context 'with missing space on the left side of the operator' do
      let(:code) { "a#{operator} b" }
      it { expect(problems).to contain_warning(message).on_line(1) }
    end

    context 'with missing space on the right side of the operator' do
      let(:code) { "a #{operator}b" }
      it { expect(problems).to contain_warning(message).on_line(1) }
    end

    context 'with new line after the operator' do
      let(:code) { "a #{operator}\nb" }
      it { expect(problems).to have(0).problems }
    end

    context 'with space on both side of operator' do
      let(:code) { "a #{operator} b" }
      it { expect(problems).to have(0).problems }
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      let(:code) { "a#{operator}b" }
      let(:fixed) { "a #{operator} b" }

      it { expect(manifest).to eq(fixed) }
    end
  end

  it_behaves_like('missing space', '=')
  it_behaves_like('missing space', '==')
  it_behaves_like('missing space', '!=')
  it_behaves_like('missing space', '=~')
  it_behaves_like('missing space', '!~')
  it_behaves_like('missing space', '+=')
  it_behaves_like('missing space', '+')
  it_behaves_like('missing space', '>=')
  it_behaves_like('missing space', '>')
  it_behaves_like('missing space', '<=')
  it_behaves_like('missing space', '<')
end
