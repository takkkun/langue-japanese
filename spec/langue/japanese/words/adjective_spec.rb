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
