# frozen_string_literal: true

require 'spec_helper'

describe Ra::Engine do
  subject(:engine) { build(:engine) }

  describe '#each' do
    it 'yields a color for each y / x pair' do
      expect { |block| engine.each(&block) }
        .to yield_control
    end
  end

  describe '#ppm' do
    it do
      expect { |block| engine.ppm(&block) }
        .to yield_control
    end
  end
end
