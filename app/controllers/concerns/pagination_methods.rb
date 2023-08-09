module PaginationMethods
  extend ActiveSupport::Concern

  def paginate_objects(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      previous_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count,
      per_page: object.limit_value
      # page_numbers: page_numbers(object)
    }
  end

  # def page_numbers(object, display_size = 5)
  #   pnums = page_number_defaults(object)
  #   return pnums if pnums.size.zero?
  #   return pnums if pnums.size == display_size # size of 5
  #   return pnums if pnums.first == 1 && pnums.last == object.total_pages # less than 5 pages

  #   half_display_size = (display_size / 2).round
  #   if object.current_page - half_display_size <= 0 # add to the end
  #     pnums << pnums.last + 1 until pnums.size == 5 || pnums.last == object.total_pages
  #   else # add to the beginning
  #     pnums.unshift(pnums.first - 1) until pnums.size == 5 || pnums.first == 1
  #   end
  #   pnums
  # end

  # def page_number_defaults(object)
  #   pnums = (object.current_page - 2..object.current_page + 2).to_a
  #   pnums.delete_if { |p| p <= 0 || p > object.total_pages }
  #   pnums
  # end
end
