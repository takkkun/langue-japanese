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
      '!! さて'      => 2,
      '? さて'       => 1,
      '?? さて'      => 2,
      '!? さて'      => 2,
      '!?! さて'     => 3,
      '!??!!?! さて' => 7,
      '、さて'       => 0,
      '，さて'       => 0,
      ', さて'       => 0
    }
  end
end
