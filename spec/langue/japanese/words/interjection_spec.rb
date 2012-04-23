# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/interjection'

describe Langue::Japanese::Interjection do
  it 'inherits Langue::Interjection' do
    described_class.superclass.should == Langue::Interjection
  end
end

describe Langue::Japanese::Interjection, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a interjection' do
    @pairs = {
      'おはよう'             => 1,
      'おはようごきげんよう' => 1
    }
  end
end
