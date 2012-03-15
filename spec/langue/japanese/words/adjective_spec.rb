# -*- coding: utf-8 -*-
require 'langue/japanese/words/adjective'
require 'langue/japanese/parser'

describe Langue::Japanese::Adjective, '.take' do
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  after do
    @pairs.each do |text, size|
      morphemes = @parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes an adjective' do
    @pairs = {
      '可愛いこと'     => 1,
      'かっこいいこと' => 1,
      '会話だ'         => 0,
      '話すこと'       => 0
    }
  end

  it 'takes an adjective with prefix' do
    @pairs = {
      'くそ可愛いこと'       => 2,
      'くそくそかっこいいこと' => 3,
      'くそ会話だ'             => 0
    }
  end

  it 'takes an adjective with suffix' do
    @pairs = {
      '可愛いっぽいこと' => 2
    }
  end

  it 'takes a successive adjective' do
    @pairs = {
      '可愛がたいこと' => 2
    }
  end

  it 'takes a negative adjective' do
    @pairs = {
      '可愛くないこと'     => 2,
      'かっこよくないこと' => 2
    }
  end

  it 'takes a perfective adjective' do
    @pairs = {
      '可愛かったこと'     => 2,
      'かっこよかったこと' => 2
    }
  end

  it 'takes a complex adjective' do
    @pairs = {
      'くそ可愛がたくなかったこと' => 5,
      'クソかっこよくないこと'     => 3,
      '美しくなかったこと'         => 3,
      '厳しいっぽくなかったこと'   => 4
    }
  end

  it 'takes an adjective by other' do
    @pairs = {
      '可愛いでしょう' => 3
    }
  end
end

describe Langue::Japanese::Adjective, '#text' do
  before :all do
    parser = Langue::Japanese::Parser.new
    @word = described_class.new(parser.parse('くそ真っ可愛い'))
  end

  it 'returns the text without the prefix' do
    @word.text.should == '可愛い'
  end
end

describe Langue::Japanese::Adjective, '#prefix' do
  before :all do
    parser = Langue::Japanese::Parser.new
    @word = described_class.new(parser.parse('くそ真っ可愛い'))
  end

  it 'returns the prefix' do
    @word.prefix.should == 'くそ真っ'
  end
end

describe Langue::Japanese::Adjective, '#full_text' do
  before :all do
    parser = Langue::Japanese::Parser.new
    @word = described_class.new(parser.parse('くそ真っ可愛い'))
  end

  it 'returns the text with the prefix' do
    @word.full_text.should == 'くそ真っ可愛い'
  end
end
