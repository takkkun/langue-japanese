# -*- coding: utf-8 -*-
require 'spec_helper'
require 'langue/japanese/words/verb'

describe Langue::Japanese::Verb do
  it 'inherits Langue::Verb' do
    described_class.superclass.should == Langue::Verb
  end
end

describe Langue::Japanese::Verb, '.take' do
  after do
    @pairs.each do |text, size|
      morphemes = parser.parse(text)
      described_class.take(morphemes, 0).should == size
    end
  end

  it 'takes a verb' do
    @pairs = {
      '話すこと'     => 1,
      '喋ること'     => 1,
      '会話だ'       => 0,
      'かわいいこと' => 0
    }
  end

  it 'takes a verb with prefix' do
    @pairs = {
      'ぶっ話すこと'     => 2,
      'ぶっぶち話すこと' => 3,
      'ぶっ会話だ'       => 0,
      'ぶっかわいいこと' => 0
    }
  end

  it 'takes a noun conjunct to suru-verb as a verb' do
    @pairs = {
      '会話すること' => 2,
      '連絡すること' => 2,
      '会話だ'       => 0
    }
  end

  it 'takes a noun conjunct to suru-verb with prefix as a verb' do
    @pairs = {
      'ご連絡すること'   => 3,
      '超反連絡すること' => 4,
      'ご連絡だ'         => 0,
      '反超すること'     => 0
    }
  end

  it 'takes a verb with suffix' do
    @pairs = {
      '話されること'     => 2,
      'ぶっ放されること' => 3,
      '会話されること'   => 3,
      'ご連絡されること' => 4,
      '聞かせること'     => 2,
      'ぶっ聞かせること' => 3
    }
  end

  it 'takes a verb with noncategorematic verb' do
    @pairs = {
      '話し続けること'     => 2,
      'ぶっ話し続けること' => 3,
      '会話し続けること'   => 3,
      'ご連絡し続けること' => 4,
      'いる'               => 0
    }
  end

  it 'takes a verb with conjunctive particle' do
    @pairs = {
      '話していること'     => 3,
      'ぶっ話していること' => 4,
      '会話していること'   => 4,
      'ご連絡していること' => 5,
      '遊んで！'           => 2,
      '話さなかったってさ' => 4,
      '話して欲しいこと'   => 2,
      '話しこそすれ'       => 1
    }
  end

  it 'takes a verb with auxiliary verb' do
    @pairs = {
      '話したいこと' => 2,
      '話したこと'   => 2,
      '話さないこと' => 2,
      '話さんこと'   => 2,
      '話します'     => 2,
      '話しません'   => 3,
      '話すでしょう' => 3,
      '話しちゃう'   => 2
    }
  end

  it 'takes a verb with final particle' do
    @pairs = {
      '話すな！'     => 2,
      '話すか？'     => 2,
      '話すかしら？' => 2,
      '話すよ！'     => 2
    }
  end

  it 'takes a complex verb' do
    @pairs = {
      '話し続けていたくなかったこと'     =>  7,
      'ぶっ話し続けていたくなかったこと' =>  8,
      '会話し続けていたくなかったこと'   =>  8,
      'ご連絡し続けていたくなかったこと' =>  9,
      'ご連絡し続けていたくなかったか？' => 10
    }
  end

  it 'does not take special verbs' do
    @pairs = {
      '思い続けていること' => 0,
      'ぶっ思います'       => 0,
      'おもわれたいこと'   => 0,
      'ぶちおもわない'     => 0
    }
  end
end

describe Langue::Japanese::Verb, '#key_morpheme' do
  it 'returns the categorematic verb or the noncategorematic verb' do
    {
      '話す'           => 0,
      '話し続けている' => 1,
      '話される'       => 0,
      '話して'         => 0,
      '話してる'       => 0,
      '話している'     => 0,
      '話しとる'       => 0,
      '話しちゃう'     => 0,
      '話したって'     => 0
    }.each do |text, index|
      word = verb(text)
      word.key_morpheme.should == word[index]
    end
  end

  context 'with an empty word' do
    it 'returns nil' do
      word = described_class.new
      word.key_morpheme.should be_nil
    end
  end
end

describe Langue::Japanese::Verb, '#prefix' do
  it 'returns the prefix' do
    verb('ぶっぶち話さない').prefix.should == 'ぶっぶち'
    verb('超ご連絡しない').prefix.should == '超ご'
  end
end

describe Langue::Japanese::Verb, '#body' do
  it 'returns the text without the attributes' do
    verb('話したくなかった').body.should == '話す'
    verb('連絡したくなかった').body.should == '連絡する'
  end

  it 'returns the text without the prefix' do
    verb('ぶっぶち話す').body.should == '話す'
    verb('超ご連絡する').body.should == '連絡する'
  end

  it 'returns the text without the progressive verb' do
    verb('話している').body.should == '話す'
    verb('話してる').body.should == '話す'
  end

  it 'returns the text without the ra verb' do
    verb('話してください').body.should == '話す'
  end
end

describe Langue::Japanese::Verb, '#progressive?' do
  it 'returns true if it is progressive' do
    verb('話している').should be_progressive
    verb('話してる').should be_progressive
    verb('話しとる').should be_progressive
    verb('富んでいる').should be_progressive
    verb('富んでる').should be_progressive
    verb('富んどる').should be_progressive
  end

  it 'returns false if it is not progressive' do
    verb('話されたくなかった').should_not be_progressive
    verb('話しちゃう').should_not be_progressive
    verb('富んじゃう').should_not be_progressive
  end
end

describe Langue::Japanese::Verb, '#passive?' do
  it 'returns true if it is passive' do
    verb('話される').should be_passive
    verb('富んでられる').should be_passive
  end

  it 'returns false if it is not passive' do
    verb('話していたくなかった').should_not be_passive
  end
end

describe Langue::Japanese::Verb, '#causative?' do
  it 'returns true if it is causative' do
    verb('聞かせる').should be_causative
    verb('続けさせる').should be_causative
  end

  it 'returns false if it is not causative' do
    verb('聞かれていたくなかった').should_not be_causative
  end
end

describe Langue::Japanese::Verb, '#aggressive?' do
  it 'returns true if it is aggressive' do
    verb('話したい').should be_aggressive
  end

  it 'returns false if it is not aggressive' do
    verb('話されていなかった').should_not be_aggressive
  end
end

describe Langue::Japanese::Verb, '#negative?' do
  it 'returns true if it is negative' do
    verb('話さない').should be_negative
    verb('話さぬ').should be_negative
    verb('話しません').should be_negative
    verb('話すな').should be_negative
  end

  it 'returns false if it is not negative' do
    verb('話されていたかった').should_not be_negative
    verb('話したな').should_not be_negative
    verb('話さなくない').should_not be_negative
  end
end

describe Langue::Japanese::Verb, '#perfective?' do
  it 'returns true if it is perfective' do
    verb('話した').should be_perfective
    verb('去りぬ').should be_perfective
  end

  it 'returns false if it is not perfective' do
    verb('話されていたくない').should_not be_perfective
  end
end

describe Langue::Japanese::Verb, '#imperative?' do
  it 'returns true if it is imperative' do
    verb('話せ').should be_imperative
    verb('寝ろよ').should be_imperative
    verb('話してください').should be_imperative
    verb('話して').should be_imperative
    verb('話してよ').should be_imperative
    verb('話すな').should be_imperative
  end

  it 'returns false if it is not imperative' do
    verb('話されていたくなかった').should_not be_imperative
    verb('話したな').should_not be_imperative
  end
end
