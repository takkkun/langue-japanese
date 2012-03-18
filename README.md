What is langue-japanese
=======================

It provides the operations to Japanese.

Installation
------------

Add this line to your application's Gemfile:

    gem 'langue'
    gem 'langue-japanese'

    # When doing morphological analysis
    gem 'mecab-ruby', :git => 'path to mecab-ruby repository'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install langue
    $ gem install langue-japanese

langue-japanese gem runs on langue gem. So it depends to langue gem.

It also uses MeCab with morphological analysis, this gem depends too to
mecab-ruby gem if you do it.

Usage
-----

    # coding: utf-8
    require 'langue-japanese'

    # Get a language class
    language = Langue['japanese'].new

    # Split to morphemes a text
    morphemes = language.parse('今日は妹と一緒にお買い物してきたよ。楽しかった〜')

    # Create a structured text from the morphemes
    text = language.structure(morphemes)

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
