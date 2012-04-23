# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/determiner'

describe Langue::Japanese::Determiner do
  it 'inherits Langue::Determiner' do
    described_class.superclass.should == Langue::Determiner
  end
end

describe Langue::Japanese::Determiner, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a determiner' do
    @pairs = {
      'おおきな太陽'         => 1,
      'おおきなおおきな太陽' => 2
    }
  end
end
