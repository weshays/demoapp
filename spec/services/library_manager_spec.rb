require 'rails_helper'

RSpec.describe LibraryManager, type: :service do
  let (:patron) { FactoryBot.create(:user) }
  let (:researcher) { FactoryBot.create(:researcher) }

  context 'Regular Patron' do
    context 'checks out a book' do
      it 'should be able to checkout a circulating book' do
        book = FactoryBot.create(:circulating_book)
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

    context 'places a book on hold' do
      it 'should not be able to place a checked out book on hold' do
        book = FactoryBot.create(:checked_out_book)
        expect(LibraryManager.checked_out?(patron, book)).to eq(true)
        expect(LibraryManager.place_hold(patron, book)).to eq(false)
      end

      it 'should not be able to place a restricted book on hold' do
        book = FactoryBot.create(:restricted_book)
        expect(LibraryManager.restricted?(patron, book)).to eq(true)
        expect(LibraryManager.place_hold(patron, book)).to eq(false)
      end

      it 'should not be able to place a book on hold that is already on hold' do
        book = FactoryBot.create(:book_on_hold)
        expect(LibraryManager.place_hold(patron, book)).to eq(false)
      end

      it 'should be able to cancel a hold so it can be placed on hold again' do
        book = FactoryBot.create(:book_on_hold)
        expect(LibraryManager.cancel_hold(patron, book)).to eq(true)
        expect(LibraryManager.place_hold(patron, book)).to eq(true)
      end

      it 'should be able to place a book on hold' do
        book = FactoryBot.create(:circulating_book)
        expect(LibraryManager.place_hold(patron, book)).to eq(true)
      end

      it 'should not be able to place more than 5 books on hold' do
        FactoryBot.create_list(:book_on_hold, 5, on_hold_by: patron)
        book = FactoryBot.create(:circulating_book)
        expect(LibraryManager.place_hold(patron, book)).to eq(false)
      end

      it 'should not be able to place hold with more than two overdue checkouts' do
        FactoryBot.create_list(:overdue_book, 3, checked_out_by: patron)
        book = FactoryBot.create(:circulating_book)
        expect(LibraryManager.place_hold(patron, book)).to eq(false)
      end

      it 'should be able to checkout a book on hold if the hold and checkout are the same person' do
        book = FactoryBot.create(:book_on_hold, on_hold_by: patron)
        expect(LibraryManager.checkout(patron, book)).to eq(true)
      end
    end
  end

  context 'Reasearcher Patron' do
    context 'checks out a book' do
      it 'should be able to checkout a circulating book' do
        book = FactoryBot.create(:circulating_book)
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

    context 'places a book on hold' do
      it 'should not be able to place a checked out book on hold' do
        book = FactoryBot.create(:checked_out_book)
        expect(LibraryManager.checked_out?(researcher, book)).to eq(true)
        expect(LibraryManager.place_hold(researcher, book)).to eq(false)
      end

      it 'should be able to place a restricted book on hold' do
        book = FactoryBot.create(:restricted_book)
        expect(LibraryManager.restricted?(researcher, book)).to eq(true)
        expect(LibraryManager.place_hold(researcher, book)).to eq(true)
      end

      it 'should not be able to place a book on hold that is already on hold' do
        book = FactoryBot.create(:book_on_hold)
        expect(LibraryManager.place_hold(researcher, book)).to eq(false)
      end

      it 'should be able to cancel a hold so it can be placed on hold again' do
        book = FactoryBot.create(:book_on_hold)
        expect(LibraryManager.cancel_hold(researcher, book)).to eq(true)
        expect(LibraryManager.place_hold(researcher, book)).to eq(true)
      end

      it 'should be able to place a book on hold' do
        book = FactoryBot.create(:circulating_book)
        expect(LibraryManager.place_hold(researcher, book)).to eq(true)
      end

      it 'should be able to place more than 5 books on hold' do
        FactoryBot.create_list(:book_on_hold, 5, on_hold_by: researcher)
        book = FactoryBot.create(:circulating_book)
        expect(LibraryManager.place_hold(researcher, book)).to eq(true)
      end
    end
  end
end
