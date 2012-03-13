# -*- coding: utf-8 -*-
require 'langue/japanese/words/noun'
require 'langue/japanese/parser'

describe Langue::Japanese::Noun, '.take' do
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  after do
    @pairs.each do |text, size|
      morphemes = @parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a noun' do
    @pairs = {
      '会話だ'         => 1,
      'かっこいいこと' => 0,
      '話すこと'       => 0,
      '大丈夫だ'       => 0,
      '健康だ'         => 0
    }
  end

  it 'takes a noun with prefix' do
    @pairs = {
      '超会話だ'         => 2,
      '超反会話だ'       => 3,
      '超大丈夫だ'       => 0,
      '反健康だ'         => 0,
      '超それだ'         => 0,
      '超若干だ'         => 0,
      '超可愛いこと'     => 0,
      '反かっこいいこと' => 0
    }
  end

  it 'takes a successive noun' do
    @pairs = {
      '緊急連絡網だ'         => 3,
      '健康大丈夫ラーメンだ' => 3,
      '精神的疾患だ'         => 3,
      '緊急大丈夫だ'         => 0
    }
  end

  it 'takes an adverbable noun' do
    @pairs = {
      '一挙だ'             => 1,
      '一挙ラーメン永年だ' => 1,
      '一挙永年ラーメンだ' => 2,
      'ラーメン永年だ'     => 1
    }
  end

  it 'does not take noun conjunct to verb' do
    @pairs = {
      '連絡する'       => 0,
      '緊急連絡する'   => 0,
      '緊急連絡網する' => 3
    }
  end

  it 'does not take noun if starts with ー' do
    @pairs = {
      'ー犬だ' => 0
    }
  end
end
