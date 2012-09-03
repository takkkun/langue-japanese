# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/particle'

describe Langue::Japanese::Particle do
  it 'inherits Langue::Particle' do
    described_class.superclass.should == Langue::Particle
  end
end

describe Langue::Japanese::Particle, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a particle' do
    @pairs = {
      'は'   => 1,
      'とは' => 2,
      'て'   => 0
    }
  end
end
