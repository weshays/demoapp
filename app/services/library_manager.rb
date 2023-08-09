class LibraryManager
  def self.checkout(user, book)
    obj = new(user, book)
    obj.checkout
  end

  def self.checked_out?(user, book)
    obj = new(user, book)
    obj.checked_out?
  end

  def self.restricted?(user, book)
    obj = new(user, book)
    obj.restricted?
  end

  def initialize(user, book)
    @user = user
    @book = book
  end

  def checkout
    return false if @book.checked_out?
    return false if @book.restricted? && !@user.researcher?

    true
  end

  def checked_out?
    @book.checked_out?
  end

  def restricted?
    @book.restricted?
  end
end
