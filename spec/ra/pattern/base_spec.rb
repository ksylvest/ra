# frozen_string_literal: true

require 'spec_helper'

describe Ra::Pattern::Base do
  subject(:pattern) { build(:pattern) }

  it { expect(pattern.transform).to be_a(Ra::Transform) }

  describe '#color' do
    subject(:color) { pattern.color(point:) }

    let(:point) { build(:point) }

    it do
      expect { color }
        .to raise_error(NotImplementedError, '#local_color must be implemented by a concrete subclass')
    end
  end
end
