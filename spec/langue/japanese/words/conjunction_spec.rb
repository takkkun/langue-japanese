# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/conjunction'

describe Langue::Japanese::Conjunction do
  it 'inherits Langue::Conjunction' do
    described_class.superclass.should == Langue::Conjunction
  end
end

describe Langue::Japanese::Conjunction, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a conjunction' do
    @pairs = {
      'だから'       => 1,
      'だからそして' => 1
    }
  end
end
