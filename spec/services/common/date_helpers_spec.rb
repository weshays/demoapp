require 'rails_helper'

class Dummy
  include Common::DateHelpers
  def self.convert_to_date(date_str)
    self.new.convert_to_date(date_str)
  end

  def self.dateify(date_str_or_obj, default_date = nil)
    self.new.dateify(date_str_or_obj, default_date)
  end
end

RSpec.describe Common::DateHelpers, type: :service do
  context 'Convert To Date' do
    it '1980-09-27' do
      expect(Dummy.convert_to_date('1980-09-27').to_s).to eq('1980-09-27')
    end

    it '09/27/1980' do
      expect(Dummy.convert_to_date('09/27/1980').to_s).to eq('1980-09-27')
    end

    it '9/27/1980' do
      expect(Dummy.convert_to_date('9/27/1980').to_s).to eq('1980-09-27')
    end

    it '09/27/80' do
      expect(Dummy.convert_to_date('09/27/80').to_s).to eq('1980-09-27')
    end

    it '9/27/80' do
      expect(Dummy.convert_to_date('9/27/80').to_s).to eq('1980-09-27')
    end

    it '19800927' do
      expect(Dummy.convert_to_date('19800927').to_s).to eq('1980-09-27')
    end

    it 'bad date' do
      expect(Dummy.convert_to_date('dog')).to be_nil
    end
  end

  context 'dateify' do
    it '1980-09-27 without default' do
      expect(Dummy.dateify('1980-09-27').to_s).to eq('1980-09-27')
    end

    it 'nil date with default' do
      expect(Dummy.dateify(nil, '1980-09-27').to_s).to eq('1980-09-27')
    end
  end
end
