# frozen_string_literal: true

require 'pathname'
require_relative 'fixtures/example'

RSpec.describe RequireRelativeDir do
  it 'has a version number' do
    expect(RequireRelativeDir::VERSION).not_to be nil
  end

  let(:dirname) { nil }
  let(:options)  { {} }
  let(:required) { call_require_relative_dir(*dirname, **options) } # Defined in fixtures/example.rb

  subject { required }

  describe 'when given a specific directory name' do
    let(:dirname) { 'example/sub' }
    it { should == [
      "#{__dir__}/fixtures/example/sub/s1.rb",
      "#{__dir__}/fixtures/example/sub/s2.rb",
    ]}

    ['s1', 's1.rb', Pathname('s1'), :s1, %w[s1 s1]].each do |except|
      describe "when given except: #{except.inspect}" do
        let(:options) { {except: except} }
        it { should == [
          "#{__dir__}/fixtures/example/sub/s2.rb",
        ]}
      end
    end
  end

  describe 'when not given any directory name' do
    it { should == [
      "#{__dir__}/fixtures/example/a.rb",
      "#{__dir__}/fixtures/example/b.rb",
      "#{__dir__}/fixtures/example/c.rb",
    ]}

    describe 'when given an except argument' do
      let(:options) { {except: %w[b c]} }
      it { should == [
        "#{__dir__}/fixtures/example/a.rb",
      ]}
    end
  end

  describe 'when the a directory name of "."' do
    let(:dirname) { '.' }
    it { should == [
      "#{__dir__}/fixtures/example.rb",
      "#{__dir__}/fixtures/f1.rb",
      "#{__dir__}/fixtures/f2.rb",
    ]}
  end

  describe 'error handling' do
    subject { -> { required } }

    describe 'when given an invalid except' do
      let(:options) { {except: %w[a.rb nonexistent]} }
      it { should raise_error(ArgumentError) }
    end

    describe 'when given an invalid dirname' do
      let(:dirname) { 'nonexistent' }
      it { should raise_error(LoadError) }
    end
  end
end
