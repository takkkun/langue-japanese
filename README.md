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

langue-japanese gem runs on langue gem. So it depends to langue gem.

It also uses MeCab with morphological analysis, this gem depends too to
mecab-ruby gem if you do it.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install langue
    $ gem install langue-japanese

Usage
-----

    # coding: utf-8
    require 'langue'
    require 'langue-japanese'

    language = Langue['japanese'].new
    text = language.structuralize('今日は妹と一緒にお買い物してきたよ')

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
