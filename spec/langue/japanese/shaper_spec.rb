# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/shaper'

describe Langue::Japanese::Shaper, '#initialize' do
  it 'sets an instance of Langue::Japanese::Logging::NullLogger to @logger' do
    parser = described_class.new
    logger = parser.instance_eval { @logger }
    logger.should be_a(Langue::Japanese::Logging::NullLogger)
  end

  context 'with logger option' do
    it 'sets the value of logger option to @logger' do
      parser = described_class.new(:logger => 'logger')
      logger = parser.instance_eval { @logger }
      logger.should == 'logger'
    end
  end
end

describe Langue::Japanese::Shaper, '#shape_person_name' do
  it 'shapes the morphemes as person name' do
    shaper = described_class.new

    {
      'あたしの名前は天道あかねよ' => ['天道あかね', 6],
      'オレの名前は早乙女乱馬だ'   => ['早乙女乱馬', 6]
    }.each do |text, params|
      name, size = params
      morphemes = parser.parse(text)
      shaped_morphemes = shaper.shape_person_name(morphemes, name)
      shaped_morphemes.should have(size).items
      morpheme = shaped_morphemes.find { |m| m.classified?(*%w(名詞 固有名詞 人名)) }
      morpheme.text.should == name
    end
  end
end
