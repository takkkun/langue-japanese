# -*- coding: utf-8 -*-
require 'langue/japanese/inflector/inflection'

describe Langue::Japanese::Inflector::Inflection, '#inflect' do
  before do
    suffixes = {
      'form'       => 'form_suffix',
      'proc'       => lambda { |options| options[:suffix] },
      '連用タ接続' => 'ta_suffix',
      '連用テ接続' => 'te_suffix'
    }

    @inflection = described_class.new 'suffix', suffixes
  end

  it 'inflects the word to the inflectional form' do
    word = @inflection.inflect('body-suffix', 'form')
    word.should == 'body-form_suffix'
  end

  it 'adds value returning from calling of its Proc as suffix to the word if the inflectional form is an instance of Proc' do
    word = @inflection.inflect('body-suffix', 'proc', :suffix => 'proc_suffix')
    word.should == 'body-proc_suffix'
  end

  it 'raises ArgumentError if the word does not end with the base suffix' do
    lambda { @inflection.inflect('body-suffi', 'form') }.should raise_error(ArgumentError, 'the word does not end with "suffix"')
  end

  it 'raises ArgumentError if the inflectional form does not defined' do
    lambda { @inflection.inflect('body-suffix', 'form1') }.should raise_error(ArgumentError, '"form1" inflectional form does not defined in the inflection')
  end

  context 'with :following option' do
    it 'adds value of :following option to the word' do
      word = @inflection.inflect('body-suffix', 'form', :following => '-following')
      word.should == 'body-form_suffix-following'
    end

    it 'converts to "タ行" from "ダ行" in first character of the following word if the inflectional form is "連用タ接続" or "連用テ接続"' do
      {
        '連用タ接続' => 'ta_suffix',
        '連用テ接続' => 'te_suffix'
      }.each do |form, suffix|
        {
          'だ' => 'た',
          'じ' => 'ち',
          'ぢ' => 'ち',
          'で' => 'て',
          'ど' => 'と'
        }.each do |following, converted_following|
          word = @inflection.inflect('body-suffix', form, :following => following)
          word.should == "body-#{suffix}#{converted_following}"
        end
      end
    end

    it 'converts to "ダ行" from "タ行" in first character of the following word if the inflectional form is "連用タ接続" or "連用テ接続"' do
      inflection = described_class.new('suffix', {
        '連用タ接続' => ['ta_suffix', true],
        '連用テ接続' => ['te_suffix', true]
      })

      {
        '連用タ接続' => 'ta_suffix',
        '連用テ接続' => 'te_suffix'
      }.each do |form, suffix|
        {
          'た' => 'だ',
          'ち' => 'じ',
          'て' => 'で',
          'と' => 'ど'
        }.each do |following, converted_following|
          word = inflection.inflect('body-suffix', form, :following => following)
          word.should == "body-#{suffix}#{converted_following}"
        end
      end
    end
  end
end
