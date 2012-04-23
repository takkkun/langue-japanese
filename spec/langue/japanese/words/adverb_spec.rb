# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/adverb'

describe Langue::Japanese::Adverb do
  it 'inherits Langue::Adverb' do
    described_class.superclass.should == Langue::Adverb
  end
end

describe Langue::Japanese::Adverb, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a adverb' do
    @pairs = {
      'とても話す'       => 1,
      'とてもとても話す' => 2
    }
  end
end
