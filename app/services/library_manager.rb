class LibraryManager
  MAX_BOOKS_ON_HOLD = 5

  def self.checkout(user, book)
    obj = new(user, book)
    obj.checkout
  end

  def self.checked_out?(user, book)
    obj = new(user, book)
    obj.checked_out?
  end

  def self.on_hold?(user, book)
    obj = new(user, book)
    obj.on_hold?
  end

  def self.cancel_hold(user, book)
    obj = new(user, book)
    obj.cancel_hold
  end

  def self.restricted?(user, book)
    obj = new(user, book)
    obj.restricted?
  end

  def self.place_hold(user, book)
    obj = new(user, book)
    obj.place_hold
  end

  def initialize(user, book)
    @user = user
    @book = book
  end

  def checked_out?
    @book.checked_out?
  end

  def restricted?
    @book.restricted?
  end

  def on_hold?
    @book.on_hold?
  end

  def cancel_hold
    return false unless @book.on_hold?

    @book.update(on_hold: false, on_hold_by_id: nil)
  end

  def checkout
    return false if @book.on_hold? && @book.on_hold_by_id != @user.id
    return false if @book.checked_out?
    return false if @book.restricted? && !@user.researcher?

    @book.update(checked_out: true, checked_out_by_id: @user.id, on_hold: false, on_hold_by_id: nil)
  end

  def place_hold
    return false if @user.max_overdue_books_reached?
    return false if @user.books_on_hold.count >= MAX_BOOKS_ON_HOLD && !@user.researcher?
    return false if @book.on_hold?
    return false if @book.checked_out?
    return false if @book.restricted? && !@user.researcher?

    @book.update(on_hold: true, on_hold_by_id: @user.id)
  end
end
