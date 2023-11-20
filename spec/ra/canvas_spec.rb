# frozen_string_literal: true

require 'spec_helper'

describe Ra::Canvas do
  subject(:canvas) { build(:canvas) }

  describe '#[]' do
    it { expect { canvas[0, -1] }.to raise_error(ArgumentError, 'y=-1 cannot be negative') }
    it { expect { canvas[-1, 0] }.to raise_error(ArgumentError, 'x=-1 cannot be negative') }
    it { expect { canvas[6, 0] }.to raise_error(ArgumentError, 'x=6 must be < 5') }
    it { expect { canvas[0, 4] }.to raise_error(ArgumentError, 'y=4 must be < 3') }
    it { expect(canvas[0, 0]).to be_a(Ra::Color) }
  end

  describe '#[]=' do
    it { expect { canvas[0, -1] = nil }.to raise_error(ArgumentError, 'y=-1 cannot be negative') }
    it { expect { canvas[-1, 0] = nil }.to raise_error(ArgumentError, 'x=-1 cannot be negative') }
    it { expect { canvas[6, 0] = nil }.to raise_error(ArgumentError, 'x=6 must be < 5') }
    it { expect { canvas[0, 4] = nil }.to raise_error(ArgumentError, 'y=4 must be < 3') }
    it { expect { canvas[0, 0] = build(:color, :uniform) }.not_to raise_error }
  end

  describe '#ppm' do
    let(:canvas) { build(:canvas, w: 2, h: 2) }
    let(:ppm) { <<~PPM }
      P3
      2 2
      255
      128 128 128
      0 0 0
      0 0 0
      128 128 128
    PPM

    it 'returns PPM' do
      canvas[0, 0] = build(:color, :uniform, value: 0.5)
      canvas[1, 1] = build(:color, :uniform, value: 0.5)
      expect(canvas.ppm).to eq(ppm)
    end
  end
end
