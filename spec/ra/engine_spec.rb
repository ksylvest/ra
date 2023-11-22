# frozen_string_literal: true

require 'spec_helper'

describe Ra::Engine do
  subject(:engine) { build(:engine) }

  describe '#render' do
    subject(:render) { engine.render }

    it { expect(render).to be_a(Ra::Canvas) }
  end
end
