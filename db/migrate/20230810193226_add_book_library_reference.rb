class AddBookLibraryReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :library, type: :uuid, null: false, index: true, foreign_key: true
  end
end
