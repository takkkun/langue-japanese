# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/period'

describe Langue::Japanese::Period do
  it 'inherits Langue::Period' do
    described_class.superclass.should == Langue::Period
  end
end

describe Langue::Japanese::Period, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a period' do
    @pairs = {
      '。さて'       => 1,
      '…… さて'    => 2,
      '‥・ さて'    => 2,
      '、、、 さて'  => 3,
      '。。。 さて'  => 3,
      '. さて'       => 1,
      '... さて'     => 3,
      '．さて'       => 1,
      '．．さて'     => 2,
      '.。．さて'    => 3,
      '、。さて'     => 2,
      '! さて'       => 1,
      '！ さて'      => 1,
      '!! さて'      => 2,
      '！！ さて'    => 2,
      '!！ さて'     => 2,
      '? さて'       => 1,
      '？ さて'      => 1,
      '?? さて'      => 2,
      '？？ さて'    => 2,
      '!? さて'      => 2,
      '！？ さて'    => 2,
      '!?! さて'     => 3,
      '！?!？ さて'  => 4,
      '!??!!?! さて' => 7,
      '、さて'       => 0,
      '，さて'       => 0,
      ', さて'       => 0
    }
  end
end

describe Langue::Japanese::Period, '#exclamation?' do
  it 'returns true if include exclamation mark' do
    period('!').should  be_exclamation
    period('！').should be_exclamation
    period('?!').should be_exclamation
  end

  it 'returns false if do not include exclamation marks' do
    period('?').should_not be_exclamation
  end
end

describe Langue::Japanese::Period, '#question?' do
  it 'returns true if include question mark' do
    period('?').should  be_question
    period('？').should be_question
    period('!?').should be_question
  end

  it 'returns false if do not include question marks' do
    period('!').should_not be_question
  end
end
