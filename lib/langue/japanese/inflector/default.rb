# -*- coding: utf-8 -*-
Langue::Japanese::Inflector.inflections do
  adjective_forms = %w(
    未然形
    未然ウ接続
    未然ヌ接続
    連用タ接続
    連用テ接続
    連用ゴザイ接続
    終止形
    終止形-感動
    連体形
    体言接続
    仮定形
    仮定縮約１
    仮定縮約２
    ガル接続
  )

  category *adjective_forms do
    inflection '形容詞・アウオ段', 'い', {
      '未然形'         => 'く',
      '未然ウ接続'     => 'かろ',
      '未然ヌ接続'     => 'から',
      '連用タ接続'     => 'かっ',
      '連用テ接続'     => 'く',
      '連用ゴザイ接続' => 'う',
      '終止形'         => 'い',
      '終止形-感動'    => '',
      '連体形'         => 'い',
      '体言接続'       => 'き',
      '仮定形'         => 'けれ',
      '仮定縮約１'     => 'けりゃ',
      '仮定縮約２'     => 'きゃ',
      'ガル接続'       => ''
    }

    inflection '形容詞・イ段', 'い', {
      '未然形'         => 'く',
      '未然ウ接続'     => 'かろ',
      '未然ヌ接続'     => 'から',
      '連用タ接続'     => 'かっ',
      '連用テ接続'     => 'く',
      '連用ゴザイ接続' => 'ゅう',
      '終止形'         => 'い',
      '終止形-感動'    => '',
      '連体形'         => 'い',
      '体言接続'       => 'き',
      '仮定形'         => 'けれ',
      '仮定縮約１'     => 'けりゃ',
      '仮定縮約２'     => 'きゃ',
      'ガル接続'       => ''
    }

    inflection '形容動詞', '', {
      '未然形'         => 'じゃ',
      '未然ウ接続'     => lambda { |options| options[:desu] ? 'でしょ' : 'だろ' },
      '未然ヌ接続'     => 'なら',
      '連用タ接続'     => lambda { |options| options[:desu] ? 'でし' : 'だっ' },
      '連用テ接続'     => lambda { |options| options[:desu] ? 'でし' : ['', true] },
      '連用ゴザイ接続' => 'で',
      '終止形'         => lambda { |options| options[:desu] ? 'です' : 'だ' },
      '終止形-感動'    => '',
      '連体形'         => 'な',
      '体言接続'       => 'な',
      '仮定形'         => 'なら',
      '仮定縮約１'     => 'なら',
      '仮定縮約２'     => 'なら',
      'ガル接続'       => ''
    }
  end

  verb_forms = %w(
    未然形
    未然ウ接続
    未然ヌ接続
    未然レル接続
    連用形
    連用タ接続
    終止形
    仮定形
    仮定縮約
    命令形
  )

  category *verb_forms do
    inflection '一段', 'る', {
      '未然形'       => '',
      '未然ウ接続'   => 'よ',
      '未然ヌ接続'   => '',
      '未然レル接続' => '',
      '連用形'       => '',
      '連用タ接続'   => '',
      '終止形'       => 'る',
      '仮定形'       => 'れ',
      '仮定縮約'     => 'りゃ',
      '命令形'       => 'ろ'
    }

    inflection '一段・クレル', 'る', {
      '未然形'       => '',
      '未然ウ接続'   => 'よ',
      '未然ヌ接続'   => '',
      '未然レル接続' => '',
      '連用形'       => '',
      '連用タ接続'   => '',
      '終止形'       => 'る',
      '仮定形'       => 'れ',
      '仮定縮約'     => 'りゃ',
      '命令形'       => ''
    }

    inflection '五段・カ行イ音便', 'く', {
      '未然形'       => 'か',
      '未然ウ接続'   => 'こ',
      '未然ヌ接続'   => 'か',
      '未然レル接続' => 'か',
      '連用形'       => 'き',
      '連用タ接続'   => 'い',
      '終止形'       => 'く',
      '仮定形'       => 'け',
      '仮定縮約'     => 'きゃ',
      '命令形'       => 'け'
    }

    inflection '五段・カ行促音便', 'く', {
      '未然形'       => 'か',
      '未然ウ接続'   => 'こ',
      '未然ヌ接続'   => 'か',
      '未然レル接続' => 'か',
      '連用形'       => 'き',
      '連用タ接続'   => 'っ',
      '終止形'       => 'く',
      '仮定形'       => 'け',
      '仮定縮約'     => 'きゃ',
      '命令形'       => 'け'
    }

    inflection '五段・カ行促音便ユク', 'く', {
      '未然形'       => 'か',
      '未然ウ接続'   => 'こ',
      '未然ヌ接続'   => 'か',
      '未然レル接続' => 'か',
      '連用形'       => 'き',
      '連用タ接続'   => 'っ',
      '終止形'       => 'く',
      '仮定形'       => 'け',
      '仮定縮約'     => 'きゃ',
      '命令形'       => 'け'
    }

    inflection 'カ変・クル', 'くる', {
      '未然形'       => 'こ',
      '未然ウ接続'   => 'こよ',
      '未然ヌ接続'   => 'こ',
      '未然レル接続' => 'こ',
      '連用形'       => 'き',
      '連用タ接続'   => 'き',
      '終止形'       => 'くる',
      '仮定形'       => 'くれ',
      '仮定縮約'     => 'くりゃ',
      '命令形'       => 'こい'
    }

    inflection 'カ変・来ル', 'る', {
      '未然形'       => '',
      '未然ウ接続'   => 'よ',
      '未然ヌ接続'   => '',
      '未然レル接続' => '',
      '連用形'       => '',
      '連用タ接続'   => '',
      '終止形'       => 'る',
      '仮定形'       => 'れ',
      '仮定縮約'     => 'りゃ',
      '命令形'       => 'い'
    }

    inflection '五段・ガ行', 'ぐ', {
      '未然形'       => 'が',
      '未然ウ接続'   => 'ご',
      '未然ヌ接続'   => 'が',
      '未然レル接続' => 'が',
      '連用形'       => 'ぎ',
      '連用タ接続'   => ['い', true],
      '終止形'       => 'ぐ',
      '仮定形'       => 'げ',
      '仮定縮約'     => 'ぎゃ',
      '命令形'       => 'げ'
    }

    inflection '五段・サ行', 'す', {
      '未然形'       => 'さ',
      '未然ウ接続'   => 'そ',
      '未然ヌ接続'   => 'さ',
      '未然レル接続' => 'さ',
      '連用形'       => 'し',
      '連用タ接続'   => 'し',
      '終止形'       => 'す',
      '仮定形'       => 'せ',
      '仮定縮約'     => 'しゃ',
      '命令形'       => 'せ'
    }

    inflection '四段・サ行', 'す', {
      '未然形'       => 'さ',
      '未然ウ接続'   => 'そ',
      '未然ヌ接続'   => 'さ',
      '未然レル接続' => 'さ',
      '連用形'       => 'し',
      '連用タ接続'   => 'し',
      '終止形'       => 'す',
      '仮定形'       => 'せ',
      '仮定縮約'     => 'しゃ',
      '命令形'       => 'せ'
    }

    inflection 'サ変・スル', 'する', {
      '未然形'       => 'し',
      '未然ウ接続'   => 'しよ',
      '未然ヌ接続'   => 'せ',
      '未然レル接続' => 'さ',
      '連用形'       => 'し',
      '連用タ接続'   => 'し',
      '終止形'       => 'する',
      '仮定形'       => 'すれ',
      '仮定縮約'     => 'すりゃ',
      '命令形'       => 'しろ'
    }

    inflection 'サ変・−スル', 'する', {
      '未然形'       => 'し',
      '未然ウ接続'   => 'しよ',
      '未然ヌ接続'   => 'し',
      '未然レル接続' => 'せ',
      '連用形'       => 'し',
      '連用タ接続'   => 'し',
      '終止形'       => 'する',
      '仮定形'       => 'すれ',
      '仮定縮約'     => 'すりゃ',
      '命令形'       => 'しろ'
    }

    inflection 'サ変・−ズル', 'ずる', {
      '未然形'       => 'ぜ',
      '未然ウ接続'   => 'ぜよ',
      '未然ヌ接続'   => 'ぜ',
      '未然レル接続' => 'ぜ',
      '連用形'       => 'じ',
      '連用タ接続'   => 'じ',
      '終止形'       => 'ずる',
      '仮定形'       => 'ずれ',
      '仮定縮約'     => 'ずりゃ',
      '命令形'       => 'じろ'
    }

    inflection '五段・タ行', 'つ', {
      '未然形'       => 'た',
      '未然ウ接続'   => 'と',
      '未然ヌ接続'   => 'た',
      '未然レル接続' => 'た',
      '連用形'       => 'ち',
      '連用タ接続'   => 'っ',
      '終止形'       => 'つ',
      '仮定形'       => 'て',
      '仮定縮約'     => 'ちゃ',
      '命令形'       => 'て'
    }

    inflection '四段・タ行', 'つ', {
      '未然形'       => 'た',
      '未然ウ接続'   => 'と',
      '未然ヌ接続'   => 'た',
      '未然レル接続' => 'た',
      '連用形'       => 'ち',
      '連用タ接続'   => 'っ',
      '終止形'       => 'つ',
      '仮定形'       => 'て',
      '仮定縮約'     => 'ちゃ',
      '命令形'       => 'て'
    }

    inflection '五段・ナ行', 'ぬ', {
      '未然形'       => 'な',
      '未然ウ接続'   => 'の',
      '未然ヌ接続'   => 'な',
      '未然レル接続' => 'な',
      '連用形'       => 'に',
      '連用タ接続'   => ['ん', true],
      '終止形'       => 'ぬ',
      '仮定形'       => 'ね',
      '仮定縮約'     => 'にゃ',
      '命令形'       => 'ね'
    }

    inflection '四段・ハ行', 'ふ', {
      '未然形'       => 'は',
      '未然ウ接続'   => 'ほ',
      '未然ヌ接続'   => 'は',
      '未然レル接続' => 'は',
      '連用形'       => 'ひ',
      '連用タ接続'   => 'っ',
      '終止形'       => 'ふ',
      '仮定形'       => 'へ',
      '仮定縮約'     => 'ひゃ',
      '命令形'       => 'へ'
    }

    inflection '五段・バ行', 'ぶ', {
      '未然形'       => 'ば',
      '未然ウ接続'   => 'ぼ',
      '未然ヌ接続'   => 'ば',
      '未然レル接続' => 'ば',
      '連用形'       => 'び',
      '連用タ接続'   => ['ん', true],
      '終止形'       => 'ぶ',
      '仮定形'       => 'べ',
      '仮定縮約'     => 'びゃ',
      '命令形'       => 'べ'
    }

    inflection  '五段・マ行', 'む', {
      '未然形'       => 'ま',
      '未然ウ接続'   => 'も',
      '未然ヌ接続'   => 'ま',
      '未然レル接続' => 'ま',
      '連用形'       => 'み',
      '連用タ接続'   => ['ん', true],
      '終止形'       => 'む',
      '仮定形'       => 'め',
      '仮定縮約'     => 'みゃ',
      '命令形'       => 'め'
    }

    inflection '五段・ラ行', 'る', {
      '未然形'       => 'ら',
      '未然ウ接続'   => 'ろ',
      '未然ヌ接続'   => 'ら',
      '未然レル接続' => 'ら',
      '連用形'       => 'り',
      '連用タ接続'   => 'っ',
      '終止形'       => 'る',
      '仮定形'       => 'れ',
      '仮定縮約'     => 'りゃ',
      '命令形'       => 'れ'
    }

    inflection '五段・ラ行特殊', 'る', {
      '未然形'       => 'ら',
      '未然ウ接続'   => 'ろ',
      '未然ヌ接続'   => 'ら',
      '未然レル接続' => 'ら',
      '連用形'       => 'い',
      '連用タ接続'   => 'っ',
      '終止形'       => 'る',
      '仮定形'       => 'れ',
      '仮定縮約'     => 'りゃ',
      '命令形'       => 'い'
    }

    inflection '五段・ワ行ウ音便', 'う', {
      '未然形'       => 'わ',
      '未然ウ接続'   => 'お',
      '未然ヌ接続'   => 'わ',
      '未然レル接続' => 'わ',
      '連用形'       => 'い',
      '連用タ接続'   => 'う',
      '終止形'       => 'う',
      '仮定形'       => 'え',
      '仮定縮約'     => 'や',
      '命令形'       => 'え'
    }

    inflection '五段・ワ行促音便', 'う', {
      '未然形'       => 'わ',
      '未然ウ接続'   => 'お',
      '未然ヌ接続'   => 'わ',
      '未然レル接続' => 'わ',
      '連用形'       => 'い',
      '連用タ接続'   => 'っ',
      '終止形'       => 'う',
      '仮定形'       => 'え',
      '仮定縮約'     => 'や',
      '命令形'       => 'え'
    }
  end

  auxiliary_verb_forms = %w()

  category *auxiliary_verb_forms do
  end

  inflection '特殊・ナイ', 'ない', {
    '未然ウ接続'     => 'なかろ',
    '未然ヌ接続'     => 'なから',
    '連用タ接続'     => 'なかっ',
    '連用テ接続'     => 'なく',
    '連用デ接続'     => 'ない',
    '連用ゴザイ接続' => 'のう',
    '終止形'         => 'ない',
    '音便終止形'     => 'ねえ',
    '体言接続'       => 'なき',
    '仮定形'         => 'なけれ',
    '仮定縮約１'     => 'なけりゃ',
    '仮定縮約２'     => 'なきゃ',
    'ガル接続'       => 'な',
    '命令形'         => 'なかれ'
  }

  inflection '特殊・タイ', 'たい', {
    '未然ウ接続'     => 'たかろ',
    '未然ヌ接続'     => 'たから',
    '連用タ接続'     => 'たかっ',
    '連用テ接続'     => 'たく',
    '連用ゴザイ接続' => 'とう',
    '終止形'         => 'たい',
    '音便終止形'     => 'てえ',
    '体言接続'       => 'たき',
    '仮定形'         => 'たけれ',
    '仮定縮約１'     => 'たけりゃ',
    '仮定縮約２'     => 'たきゃ',
    'ガル接続'       => 'た'
  }

  inflection '特殊・デス', 'す', {
    '未然形' => 'しょ',
    '連用形' => 'し',
    '終止形' => 'す'
  }

  inflection '特殊・マス', 'す', {
    '終止形'     => 'す',
    '未然形'     => 'せ',
    '未然ウ接続' => 'しょ',
    '連用形'     => 'し',
    '仮定形'     => 'すれ',
    '命令形'     => 'せ'
  }

  inflection '特殊・タ', '', {
    '未然形' => 'ろ',
    '終止形' => '',
    '仮定形' => 'ら'
  }

  inflection '特殊・ダ', 'だ', {
    '未然形'     => 'だろ',
    '連用形'     => 'で',
    '連用タ接続' => 'だっ',
    '終止形'     => 'だ',
    '体言接続'   => 'な',
    '仮定形'     => 'なら',
    '命令形'     => 'なれ'
  }
end
