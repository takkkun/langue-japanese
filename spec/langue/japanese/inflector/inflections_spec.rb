require 'langue/japanese/inflector/inflections'

describe Langue::Japanese::Inflector::Inflections, '#inflection' do
  before do
    @inflections = described_class.new
  end

  it 'calls Langue::Japanese::Inflector::Inflection.new with the base suffix and the suffixes' do
    Langue::Japanese::Inflector::Inflection.should_receive(:new).with('suffix', 'form' => 'suffix')
    @inflections.inflection('classification', 'suffix', 'form' => 'suffix')
  end

  it 'defines the inflection' do
    @inflections.inflection('classification', 'suffix', 'form' => 'suffix')
    @inflections['classification'].should be_a(Langue::Japanese::Inflector::Inflection)
  end

  context 'in call #category' do
    it 'does not raise ArgumentError if defined the inflectional forms in just proportion' do
      lambda {
        @inflections.category 'form' do
          inflection 'classification', 'suffix', 'form' => 'suffix'
        end
      }.should_not raise_error(ArgumentError)
    end

    it 'raises ArgumentError if the inflectional forms is excess' do
      lambda {
        @inflections.category *%w(form1 form2 form3) do
          inflection 'classification', 'suffix'
        end
      }.should raise_error(ArgumentError, 'form1, form2 and form3 has not been defined')
    end

    it 'raises ArgumentError if the inflectional forms is inadequate' do
      lambda {
        @inflections.category 'form' do
          inflection 'classification', 'suffix', {
            'form'  => 'suffix',
            'form1' => 'suffix1'
          }
        end
      }.should raise_error(ArgumentError, 'form1 should not be defined')
    end

    it 'raises ArgumentError if the inflectional forms is excess and inadequate' do
      lambda {
        @inflections.category *%w(form1 form2) do
          inflection 'classification', 'suffix', {
            'form3' => 'suffix3',
            'form4' => 'suffix4'
          }
        end
      }.should raise_error(ArgumentError, 'form1 and form2 has not been defined, and form3 and form4 should not be defined')
    end
  end
end

describe Langue::Japanese::Inflector::Inflections, '#category' do
  before do
    @inflections = described_class.new
  end

  it 'calls the block in scope of the instance' do
    matcher = equal(@inflections)
    @inflections.category { should matcher }
  end
end

describe Langue::Japanese::Inflector::Inflections, '#categorizing?' do
  before do
    @inflections = described_class.new
  end

  it 'returns false after initializing' do
    @inflections.should_not be_categorizing
  end

  it 'returns true in call #category' do
    matcher = be_categorizing
    @inflections.category { should matcher }
  end
end
