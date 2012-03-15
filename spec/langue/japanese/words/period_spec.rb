# -*- coding: utf-8 -*-
require 'langue/japanese/words/period'
require 'langue/japanese/parser'

describe Langue::Japanese::Period, '.take' do
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  after do
    @pairs.each do |text, size|
      morphemes = @parser.parse(text)
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
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  it 'returns true if include exclamation mark' do
    described_class.new(@parser.parse('!')).should  be_exclamation
    described_class.new(@parser.parse('！')).should be_exclamation
    described_class.new(@parser.parse('?!')).should be_exclamation
  end

  it 'returns false if do not include exclamation marks' do
    described_class.new(@parser.parse('?')).should_not  be_exclamation
  end
end

describe Langue::Japanese::Period, '#question?' do
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  it 'returns true if include question mark' do
    described_class.new(@parser.parse('?')).should  be_question
    described_class.new(@parser.parse('？')).should be_question
    described_class.new(@parser.parse('!?')).should be_question
  end

  it 'returns false if do not include question marks' do
    described_class.new(@parser.parse('!')).should_not  be_question
  end
end
