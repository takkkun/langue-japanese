# -*- coding: utf-8 -*-
require 'langue/japanese/words/adjective_noun'
require 'langue/japanese/parser'

$parser ||= Langue::Japanese::Parser.new

def adjective_noun(text)
  morphemes = $parser.parse(text)
  Langue::Japanese::AdjectiveNoun.new(morphemes)
end

describe Langue::Japanese::AdjectiveNoun, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = $parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes an adjective noun' do
    @pairs = {
      '大丈夫だ'       => 1,
      '健康だ'         => 1,
      'かっこいいこと' => 0,
      '会話だ'         => 0,
      '話すこと'       => 0
    }
  end

  it 'takes an adjective noun with prefix' do
    @pairs = {
      '超大丈夫だ'       => 2,
      '反健康だ'         => 2,
      '超それだ'         => 0,
      '超若干だ'         => 0,
      '超可愛いこと'     => 0,
      '反かっこいいこと' => 0
    }
  end

  it 'takes an adjective noun with suffix' do
    @pairs = {
      '病気がちだ' => 2,
      '犬好きだ'   => 2,
      '犬だ'       => 0,
      'それがちだ' => 0,
      '若干がちだ' => 0
    }
  end

  it 'takes a successive adjective noun' do
    @pairs = {
      '健康大丈夫だ'         => 2,
      '健康大丈夫がちだ'     => 2,
      '健康大丈夫ラーメンだ' => 0
    }
  end

  it 'takes a complex adjective' do
    @pairs = {
      '超病気がちだ'           => 3,
      '超漆黒病気がちだ'       => 4,
      '反超健康大丈夫だ'       => 4,
      '反超健康大丈夫がちだ'   => 4,
      '超犬だ'                 => 0,
      '超健康大丈夫ラーメンだ' => 0,
      '精神的疾患だ'           => 0
    }
  end
end

describe Langue::Japanese::AdjectiveNoun, '#prefix' do
  it 'returns the prefix' do
    adjective_noun('反超病気がち').prefix.should == '反超'
  end
end

describe Langue::Japanese::AdjectiveNoun, '#body' do
  it 'returns the text with the prefix' do
    adjective_noun('反超病気がち').body.should == '病気がち'
  end
end

