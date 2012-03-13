# -*- coding: utf-8 -*-
require 'langue/japanese/words/verb'
require 'langue/japanese/parser'

describe Langue::Japanese::Verb, '.take' do
  before :all do
    @parser = Langue::Japanese::Parser.new
  end

  after do
    @pairs.each do |text, size|
      morphemes = @parser.parse(text)
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
      '会話だ'       => 0,
      'すること'     => 0
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
      'ご連絡されること' => 4
    }
  end

  it 'takes a successive verb' do
    @pairs = {
      '話し続けること'     => 2,
      'ぶっ話し続けること' => 3,
      '会話し続けること'   => 3,
      'ご連絡し続けること' => 4
    }
  end

  it 'takes a progressive verb' do
    @pairs = {
      '話していること'     => 3,
      '話してること'       => 2,
      'ぶっ話していること' => 4,
      'ぶっ話してること'   => 3,
      '会話していること'   => 4,
      '会話してること'     => 3,
      'ご連絡していること' => 5,
      'ご連絡してること'   => 4
    }
  end

  it 'takes a negative verb' do
    @pairs = {
      '話さないこと'     => 2,
      'ぶっ話さないこと' => 3,
      '会話しないこと'   => 3,
      'ご連絡しないこと' => 4
    }
  end

  it 'takes a "wanna" verb' do
    @pairs = {
      '話したいこと'     => 2,
      'ぶっ話したいこと' => 3,
      '会話したいこと'   => 3,
      'ご連絡したいこと' => 4
    }
  end

  it 'takes a perfective verb' do
    @pairs = {
      '話したこと'     => 2,
      'ぶっ話したこと' => 3,
      '会話したこと'   => 3,
      'ご連絡したこと' => 4
    }
  end

  it 'takes a complex verb' do
    @pairs = {
      '話し続けていたくなかったこと'     => 7,
      'ぶっ話し続けていたくなかったこと' => 8,
      '会話し続けていたくなかったこと'   => 8,
      'ご連絡し続けていたくなかったこと' => 9
    }
  end

  it 'takes a verb by other' do
    @pairs = {
      '話しましょう' => 3,
      '話さぬこと'   => 2
    }
  end

  it 'does not take special verbs' do
    @pairs = {
      'しましょう'         => 0,
      'ぶっしましょう'     => 0,
      'なるでしょう'       => 0,
      'ぶちなること'       => 0,
      '思い続けていること' => 0,
      'ぶっ思います'       => 0,
      'おもわれたいこと'   => 0,
      'ぶちおもわない'     => 0
    }
  end
end
