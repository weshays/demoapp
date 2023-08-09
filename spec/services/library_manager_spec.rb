require 'rails_helper'

RSpec.describe LibraryManager, type: :service do
  let (:patron) { FactoryBot.create(:user) }
  let (:researcher) { FactoryBot.create(:researcher) }

  context 'Regular Patron' do
    context 'checks out a circulating book' do
      it 'should be able to checkout a circulating book' do
        book = FactoryBot.create(:book)
        expect(LibraryManager.checkout(patron, book)).to eq(true)
      end

      it 'should not be able to checkout a restricted book' do
        book = FactoryBot.create(:restricted_book)
        expect(LibraryManager.restricted?(patron, book)).to eq(true)
        expect(LibraryManager.checkout(patron, book)).to eq(false)
      end

      it 'should not be able to checkout a book that is already checked out' do
        book = FactoryBot.create(:checked_out_book)
        expect(LibraryManager.checked_out?(patron, book)).to eq(true)
        expect(LibraryManager.checkout(patron, book)).to eq(false)
      end

      it 'should not be able to checkout a book that is already checked out by the same patron' do
        book = FactoryBot.create(:checked_out_book)
        expect(LibraryManager.checked_out?(patron, book)).to eq(true)
        expect(LibraryManager.checkout(patron, book)).to eq(false)
      end
    end
  end

  context 'Reasearcher Patron' do
    it 'should be able to checkout a circulating book' do
      book = FactoryBot.create(:book)
      expect(LibraryManager.checkout(researcher, book)).to eq(true)
    end

    it 'should be able to checkout a restricted book' do
      book = FactoryBot.create(:restricted_book)
      expect(LibraryManager.restricted?(researcher, book)).to eq(true)
      expect(LibraryManager.checkout(researcher, book)).to eq(true)
    end

    it 'should not be able to checkout a book that is already checked out' do
      book = FactoryBot.create(:checked_out_book)
      expect(LibraryManager.checked_out?(researcher, book)).to eq(true)
      expect(LibraryManager.checkout(researcher, book)).to eq(false)
    end

    it 'should not be able to checkout a book that is already checked out by the same researcher' do
      book = FactoryBot.create(:checked_out_book)
      expect(LibraryManager.checked_out?(researcher, book)).to eq(true)
      expect(LibraryManager.checkout(researcher, book)).to eq(false)
    end
  end
end
