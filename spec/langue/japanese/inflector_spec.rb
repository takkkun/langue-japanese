# -*- coding: utf-8 -*-
require 'langue/japanese/inflector'

describe Langue::Japanese::Inflector, '#initialize' do
  it 'sets an instance of Langue::Japanese::Logging::NullLogger to @logger' do
    inflector = described_class.new
    logger = inflector.instance_variable_get(:@logger)
    logger.should be_a(Langue::Japanese::Logging::NullLogger)
  end

  context 'with :logger option' do
    it 'sets the value of :logger option to @logger' do
      inflector = described_class.new(:logger => 'logger')
      logger = inflector.instance_variable_get(:@logger)
      logger.should == 'logger'
    end
  end
end

describe Langue::Japanese::Inflector, '#inflect' do
  before do
    @inflector = described_class.new
  end

  it 'calls #inflect of the inflection with the word, with inflectional form and the options' do
    inflection = mock.tap do |m|
      m.should_receive(:inflect).with('word', 'form', :key => 'value')
    end

    described_class.inflections.stub!(:[]).with('classification').and_return(inflection)
    @inflector.inflect('classification', 'word', 'form', :key => 'value')
  end

  it 'raises ArgumentError if the inflectional classification does not exist' do
    lambda { @inflector.inflect('classification', 'word', 'form') }.should raise_error(ArgumentError, '"classification" inflection does not exist')
  end

  context 'with an adjective' do
    context 'with 形容詞・アウオ段' do
      before do
        @inflection_name = '形容詞・アウオ段'
        @word = '賢い'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '賢く'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '賢かろ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '賢から'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続').should == '賢かっ'
      end

      it 'inflects to 連用テ接続' do
        @inflector.inflect(@inflection_name, @word, '連用テ接続', :following => 'て').should == '賢くて'
      end

      it 'inflects to 連用ゴザイ接続' do
        @inflector.inflect(@inflection_name, @word, '連用ゴザイ接続').should == '賢う'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '賢い'
      end

      it 'inflects to 終止形-感動' do
        @inflector.inflect(@inflection_name, @word, '終止形-感動').should == '賢'
      end

      it 'inflects to 連体形' do
        @inflector.inflect(@inflection_name, @word, '連体形').should == '賢い'
      end

      it 'inflects to 体言接続' do
        @inflector.inflect(@inflection_name, @word, '体言接続').should == '賢き'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '賢けれ'
      end

      it 'inflects to 仮定縮約１' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約１').should == '賢けりゃ'
      end

      it 'inflects to 仮定縮約２' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約２').should == '賢きゃ'
      end

      it 'inflects to ガル接続' do
        @inflector.inflect(@inflection_name, @word, 'ガル接続').should == '賢'
      end
    end

    context 'with 形容詞・イ段' do
      before do
        @inflection_name = '形容詞・イ段'
        @word = '楽しい'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '楽しく'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '楽しかろ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '楽しから'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続').should == '楽しかっ'
      end

      it 'inflects to 連用テ接続' do
        @inflector.inflect(@inflection_name, @word, '連用テ接続', :following => 'て').should == '楽しくて'
      end

      it 'inflects to 連用ゴザイ接続' do
        @inflector.inflect(@inflection_name, @word, '連用ゴザイ接続').should == '楽しゅう'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '楽しい'
      end

      it 'inflects to 終止形-感動' do
        @inflector.inflect(@inflection_name, @word, '終止形-感動').should == '楽し'
      end

      it 'inflects to 連体形' do
        @inflector.inflect(@inflection_name, @word, '連体形').should == '楽しい'
      end

      it 'inflects to 体言接続' do
        @inflector.inflect(@inflection_name, @word, '体言接続').should == '楽しき'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '楽しけれ'
      end

      it 'inflects to 仮定縮約１' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約１').should == '楽しけりゃ'
      end

      it 'inflects to 仮定縮約２' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約２').should == '楽しきゃ'
      end

      it 'inflects to ガル接続' do
        @inflector.inflect(@inflection_name, @word, 'ガル接続').should == '楽し'
      end
    end
  end

  context 'with an adjectival noun' do
    before do
      @inflection_name = '形容動詞'
      @word = '静か'
    end

    it 'inflects to 未然形' do
      @inflector.inflect(@inflection_name, @word, '未然形').should == '静かじゃ'
    end

    it 'inflects to 未然ウ接続' do
      @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '静かだろ'
    end

    it 'inflects to 未然ヌ接続' do
      @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '静かなら'
    end

    it 'inflects to 連用タ接続' do
      @inflector.inflect(@inflection_name, @word, '連用タ接続').should == '静かだっ'
    end

    it 'inflects to 連用テ接続' do
      @inflector.inflect(@inflection_name, @word, '連用テ接続', :following => 'て').should == '静かで'
    end

    it 'inflects to 連用ゴザイ接続' do
      @inflector.inflect(@inflection_name, @word, '連用ゴザイ接続').should == '静かで'
    end

    it 'inflects to 終止形' do
      @inflector.inflect(@inflection_name, @word, '終止形').should == '静かだ'
    end

    it 'inflects to 終止形-感動' do
      @inflector.inflect(@inflection_name, @word, '終止形-感動').should == '静か'
    end

    it 'inflects to 連体形' do
      @inflector.inflect(@inflection_name, @word, '連体形').should == '静かな'
    end

    it 'inflects to 体言接続' do
      @inflector.inflect(@inflection_name, @word, '体言接続').should == '静かな'
    end

    it 'inflects to 仮定形' do
      @inflector.inflect(@inflection_name, @word, '仮定形').should == '静かなら'
    end

    it 'inflects to 仮定縮約１' do
      @inflector.inflect(@inflection_name, @word, '仮定縮約１').should == '静かなら'
    end

    it 'inflects to 仮定縮約２' do
      @inflector.inflect(@inflection_name, @word, '仮定縮約２').should == '静かなら'
    end

    it 'inflects to ガル接続' do
      @inflector.inflect(@inflection_name, @word, 'ガル接続').should == '静か'
    end

    context 'with :desu option' do
      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続', :desu => true).should == '静かでしょ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :desu => true).should == '静かでし'
      end

      it 'inflects to 連用テ接続' do
        @inflector.inflect(@inflection_name, @word, '連用テ接続', :following => 'て', :desu => true).should == '静かでして'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形', :desu => true).should == '静かです'
      end
    end
  end

  context 'with a verb' do
    context 'with 一段' do
      before do
        @inflection_name = '一段'
        @word = '食べる'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '食べ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '食べよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '食べ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '食べ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '食べ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '食べた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '食べる'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '食べれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '食べりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '食べろ'
      end
    end

    context 'with 一段・クレル' do
      before do
        @inflection_name = '一段・クレル'
        @word = '呉れる'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '呉れ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '呉れよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '呉れ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '呉れ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '呉れ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '呉れた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '呉れる'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '呉れれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '呉れりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '呉れ'
      end
    end

    context 'with 五段・カ行イ音便' do
      before do
        @inflection_name = '五段・カ行イ音便'
        @word = '書く'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '書か'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '書こ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '書か'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '書か'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '書き'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '書いた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '書く'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '書け'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '書きゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '書け'
      end
    end

    context 'with 五段・カ行促音便' do
      before do
        @inflection_name = '五段・カ行促音便'
        @word = '付いて行く'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '付いて行か'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '付いて行こ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '付いて行か'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '付いて行か'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '付いて行き'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '付いて行った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '付いて行く'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '付いて行け'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '付いて行きゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '付いて行け'
      end
    end

    context 'with 五段・カ行促音便ユク' do
      before do
        @inflection_name = '五段・カ行促音便ユク'
        @word = '心行く'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '心行か'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '心行こ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '心行か'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '心行か'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '心行き'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '心行った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '心行く'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '心行け'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '心行きゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '心行け'
      end
    end

    context 'with カ変・クル' do
      before do
        @inflection_name = 'カ変・クル'
        @word = 'くる'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == 'こ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == 'こよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == 'こ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == 'こ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == 'き'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == 'きた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == 'くる'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == 'くれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == 'くりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == 'こい'
      end
    end

    context 'with カ変・来ル' do
      before do
        @inflection_name = 'カ変・来ル'
        @word = '来る'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '来'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '来よ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '来'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '来'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '来'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '来た'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '来る'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '来れ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '来りゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '来い'
      end
    end

    context 'with 五段・ガ行' do
      before do
        @inflection_name = '五段・ガ行'
        @word = '仰ぐ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '仰が'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '仰ご'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '仰が'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '仰が'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '仰ぎ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '仰いだ'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '仰ぐ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '仰げ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '仰ぎゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '仰げ'
      end
    end

    context 'with 五段・サ行' do
      before do
        @inflection_name = '五段・サ行'
        @word = '話す'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '話さ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '話そ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '話さ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '話さ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '話し'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '話した'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '話す'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '話せ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '話しゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '話せ'
      end
    end

    context 'with 四段・サ行' do
      before do
        @inflection_name = '四段・サ行'
        @word = '天照らす'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '天照らさ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '天照らそ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '天照らさ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '天照らさ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '天照らし'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '天照らした'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '天照らす'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '天照らせ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '天照らしゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '天照らせ'
      end
    end

    context 'with サ変・スル' do
      before do
        @inflection_name = 'サ変・スル'
        @word = 'する'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == 'し'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == 'しよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == 'せ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == 'さ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == 'し'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == 'した'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == 'する'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == 'すれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == 'すりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == 'しろ'
      end
    end

    context 'with サ変・−スル' do
      before do
        @inflection_name = 'サ変・−スル'
        @word = '発する'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '発し'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '発しよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '発し'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '発せ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '発し'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '発した'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '発する'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '発すれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '発すりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '発しろ'
      end
    end

    context 'with サ変・−ズル' do
      before do
        @inflection_name = 'サ変・−ズル'
        @word = '存ずる'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '存ぜ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '存ぜよ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '存ぜ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '存ぜ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '存じ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '存じた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '存ずる'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '存ずれ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '存ずりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '存じろ'
      end
    end

    context 'with 五段・タ行' do
      before do
        @inflection_name = '五段・タ行'
        @word = '持つ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '持た'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '持と'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '持た'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '持た'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '持ち'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '持った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '持つ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '持て'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '持ちゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '持て'
      end
    end

    context 'with 四段・タ行' do
      before do
        @inflection_name = '四段・タ行'
        @word = '群立つ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '群立た'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '群立と'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '群立た'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '群立た'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '群立ち'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '群立った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '群立つ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '群立て'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '群立ちゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '群立て'
      end
    end

    context 'with 五段・ナ行' do
      before do
        @inflection_name = '五段・ナ行'
        @word = '死ぬ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '死な'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '死の'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '死な'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '死な'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '死に'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '死んだ'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '死ぬ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '死ね'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '死にゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '死ね'
      end
    end

    context 'with 四段・ハ行' do
      before do
        @inflection_name = '四段・ハ行'
        @word = '思ふ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '思は'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '思ほ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '思は'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '思は'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '思ひ'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '思った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '思ふ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '思へ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '思ひゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '思へ'
      end
    end

    context 'with 五段・バ行' do
      before do
        @inflection_name = '五段・バ行'
        @word = '遊ぶ'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '遊ば'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '遊ぼ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '遊ば'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '遊ば'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '遊び'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '遊んだ'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '遊ぶ'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '遊べ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '遊びゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '遊べ'
      end
    end

    context 'with 五段・マ行' do
      before do
        @inflection_name = '五段・マ行'
        @word = '編む'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '編ま'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '編も'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '編ま'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '編ま'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '編み'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '編んだ'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '編む'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '編め'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '編みゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '編め'
      end
    end

    context 'with 五段・ラ行' do
      before do
        @inflection_name = '五段・ラ行'
        @word = '走る'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '走ら'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '走ろ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '走ら'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '走ら'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '走り'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '走った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '走る'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '走れ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '走りゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '走れ'
      end
    end

    context 'with 五段・ラ行特殊' do
      before do
        @inflection_name = '五段・ラ行特殊'
        @word = 'なさる'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == 'なさら'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == 'なさろ'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == 'なさら'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == 'なさら'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == 'なさい'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == 'なさった'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == 'なさる'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == 'なされ'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == 'なさりゃ'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == 'なさい'
      end
    end

    context 'with 五段・ワ行ウ音便' do
      before do
        @inflection_name = '五段・ワ行ウ音便'
        @word = '乞う'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '乞わ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '乞お'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '乞わ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '乞わ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '乞い'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '乞うた'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '乞う'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '乞え'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '乞や'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '乞え'
      end
    end

    context 'with 五段・ワ行促音便' do
      before do
        @inflection_name = '五段・ワ行促音便'
        @word = '誘う'
      end

      it 'inflects to 未然形' do
        @inflector.inflect(@inflection_name, @word, '未然形').should == '誘わ'
      end

      it 'inflects to 未然ウ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == '誘お'
      end

      it 'inflects to 未然ヌ接続' do
        @inflector.inflect(@inflection_name, @word, '未然ヌ接続').should == '誘わ'
      end

      it 'inflects to 未然レル接続' do
        @inflector.inflect(@inflection_name, @word, '未然レル接続').should == '誘わ'
      end

      it 'inflects to 連用形' do
        @inflector.inflect(@inflection_name, @word, '連用形').should == '誘い'
      end

      it 'inflects to 連用タ接続' do
        @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == '誘った'
      end

      it 'inflects to 終止形' do
        @inflector.inflect(@inflection_name, @word, '終止形').should == '誘う'
      end

      it 'inflects to 仮定形' do
        @inflector.inflect(@inflection_name, @word, '仮定形').should == '誘え'
      end

      it 'inflects to 仮定縮約' do
        @inflector.inflect(@inflection_name, @word, '仮定縮約').should == '誘や'
      end

      it 'inflects to 命令形' do
        @inflector.inflect(@inflection_name, @word, '命令形').should == '誘え'
      end
    end
  end

  context 'with 特殊・デス' do
    before do
      @inflection_name = '特殊・デス'
      @word = 'です'
    end

    it 'inflects to 未然形' do
      @inflector.inflect(@inflection_name, @word, '未然形').should == 'でしょ'
    end

    it 'inflects to 連用形' do
      @inflector.inflect(@inflection_name, @word, '連用形').should == 'でし'
    end

    it 'inflects to 終止形' do
      @inflector.inflect(@inflection_name, @word, '終止形').should == 'です'
    end
  end

  context 'with 特殊・マス' do
    before do
      @inflection_name = '特殊・マス'
      @word = 'ます'
    end

    it 'inflects to 未然形' do
      @inflector.inflect(@inflection_name, @word, '未然形').should == 'ませ'
    end

    it 'inflects to 未然ウ接続' do
      @inflector.inflect(@inflection_name, @word, '未然ウ接続').should == 'ましょ'
    end

    it 'inflects to 連用形' do
      @inflector.inflect(@inflection_name, @word, '連用形').should == 'まし'
    end

    it 'inflects to 終止形' do
      @inflector.inflect(@inflection_name, @word, '終止形').should == 'ます'
    end

    it 'inflects to 仮定形' do
      @inflector.inflect(@inflection_name, @word, '仮定形').should == 'ますれ'
    end

    it 'inflects to 命令形' do
      @inflector.inflect(@inflection_name, @word, '命令形').should == 'ませ'
    end
  end

  context 'with 特殊・タ' do
    before do
      @inflection_name = '特殊・タ'
      @word = 'た'
    end

    it 'inflects to 未然形' do
      @inflector.inflect(@inflection_name, @word, '未然形').should == 'たろ'
    end

    it 'inflects to 終止形' do
      @inflector.inflect(@inflection_name, @word, '終止形').should == 'た'
    end

    it 'inflects to 仮定形' do
      @inflector.inflect(@inflection_name, @word, '仮定形').should == 'たら'
    end
  end

  context 'with 特殊・ダ' do
    before do
      @inflection_name = '特殊・ダ'
      @word = 'だ'
    end

    it 'inflects to 未然形' do
      @inflector.inflect(@inflection_name, @word, '未然形').should == 'だろ'
    end

    it 'inflects to 連用形' do
      @inflector.inflect(@inflection_name, @word, '連用形').should == 'で'
    end

    it 'inflects to 連用タ接続' do
      @inflector.inflect(@inflection_name, @word, '連用タ接続', :following => 'た').should == 'だった'
    end

    it 'inflects to 終止形' do
      @inflector.inflect(@inflection_name, @word, '終止形').should == 'だ'
    end

    it 'inflects to 体言接続' do
      @inflector.inflect(@inflection_name, @word, '体言接続').should == 'な'
    end

    it 'inflects to 仮定形' do
      @inflector.inflect(@inflection_name, @word, '仮定形').should == 'なら'
    end

    it 'inflects to 命令形' do
      @inflector.inflect(@inflection_name, @word, '命令形').should == 'なれ'
    end
  end
end
