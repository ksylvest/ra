# frozen_string_literal: true

require 'spec_helper'

describe Ra::Camera do
  subject(:camera) { build(:camera) }

  it { expect(camera.h).to be_a(Integer) }
  it { expect(camera.w).to be_a(Integer) }
  it { expect(camera.fov).to be_a(Float) }
  it { expect(camera.transform).to eq(Ra::Transform::IDENTITY) }

  describe '#each' do
    it 'yields a ray for each y / x pair' do
      expect { |block| camera.each(&block) }
        .to yield_control
    end
  end

  describe '#half_view' do
    subject(:half_view) { camera.half_view.round(8) }

    it { expect(half_view).to eq(1.0) }
  end

  describe '#half_w' do
    subject(:half_w) { camera.half_w.round(8) }

    let(:camera) { build(:camera, w:, h:) }

    context 'when w = 5 / h = 4 (portrait)' do
      let(:w) { 5 }
      let(:h) { 4 }

      it { expect(half_w).to eq(1.0) }
    end

    context 'when w = 4 / h = 5 (landscape)' do
      let(:w) { 4 }
      let(:h) { 5 }

      it { expect(half_w).to eq(0.8) }
    end
  end

  describe '#half_h' do
    subject(:half_h) { camera.half_h.round(8) }

    let(:camera) { build(:camera, w:, h:) }

    context 'when w = 5 / h = 4 (landscape)' do
      let(:w) { 5 }
      let(:h) { 4 }

      it { expect(half_h).to eq(0.8) }
    end

    context 'when w = 4 / h = 5 (portrait)' do
      let(:w) { 4 }
      let(:h) { 5 }

      it { expect(half_h).to eq(1.0) }
    end
  end

  describe '#p_size' do
    subject(:p_size) { camera.p_size.round(8) }

    let(:camera) { build(:camera, w:, h:) }

    context 'when w = 5 / h = 3 (landscape)' do
      let(:w) { 5 }
      let(:h) { 3 }

      it { expect(p_size).to eq(0.4) }
    end

    context 'when w = 3 / h = 5 (portrait)' do
      let(:w) { 3 }
      let(:h) { 5 }

      it { expect(p_size).to eq(0.4) }
    end
  end

  describe '#ray' do
    subject(:ray) { camera.ray(x:, y:) }

    let(:camera) { build(:camera, w:, h:) }

    context 'when w = 5 / h = 3 / x = 2 / y = 1' do
      let(:w) { 5 }
      let(:h) { 3 }
      let(:x) { 2 }
      let(:y) { 1 }

      it { expect(ray.origin).to eq(build(:point, x: 0, y: 0, z: 0)) }
      it { expect(ray.direction[0].round(8)).to eq(0.0) }
      it { expect(ray.direction[1].round(8)).to eq(0.0) }
      it { expect(ray.direction[2].round(8)).to eq(-1.0) }
      it { expect(ray.direction[3]).to eq(Ra::Tuple::VECTOR) }
    end

    context 'when w = 5 / h = 3 / x = 0 / y = 0' do
      let(:w) { 5 }
      let(:h) { 3 }
      let(:x) { 0 }
      let(:y) { 0 }

      it { expect(ray.origin).to eq(build(:point, x: 0, y: 0, z: 0)) }
      it { expect(ray.direction[0].round(8)).to eq(0.59628479) }
      it { expect(ray.direction[1].round(8)).to eq(0.29814240) }
      it { expect(ray.direction[2].round(8)).to eq(-0.74535599) }
      it { expect(ray.direction[3].round(8)).to eq(Ra::Tuple::VECTOR) }
    end
  end
end
