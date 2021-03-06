# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/pronoun'

describe Langue::Japanese::Pronoun do
  it 'inherits Langue::Pronoun' do
    described_class.superclass.should == Langue::Pronoun
  end
end

describe Langue::Japanese::Pronoun, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a pronoun' do
    @pairs = {
      'それだ'         => 1,
      '僕だ'           => 1,
      'それ僕だ'       => 1,
      '会話それだ'     => 0,
      'かっこいいこと' => 0,
      '会話だ'         => 0,
      '話すこと'       => 0
    }
  end
end
