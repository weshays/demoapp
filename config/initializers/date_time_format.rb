# used for displaying the date throughout the application. Since some database fields are
# both of type Date and DateTime add  the format to both.
Time::DATE_FORMATS[:basic_date] = "%-m/%-d/%Y"
Date::DATE_FORMATS[:basic_date] = "%-m/%-d/%Y"
Time::DATE_FORMATS[:basic_short_date] = "%-m/%-d/%y"
Date::DATE_FORMATS[:basic_short_date] = "%-m/%-d/%y"

Time::DATE_FORMATS[:basic_time] = "%l:%M %p"
Date::DATE_FORMATS[:basic_time] = "%l:%M %p"

Time::DATE_FORMATS[:basic_time_without_leading_zero] = "%l:%M %p"
Date::DATE_FORMATS[:basic_time_without_leading_zero] = "%l:%M %p"

Time::DATE_FORMATS[:full_stamp] = "%a %B %d at %I:%M %p"
Time::DATE_FORMATS[:short_stamp] = '%-m/%-d/%y %l:%M %p' # shorter than :full_stamp to conserve column space (and no seconds)
Time::DATE_FORMATS[:import_stamp] = '%Y-%m-%d %l:%M %p' # shorter than :full_stamp to conserve column space (and no seconds)

Time::DATE_FORMATS[:condensed_stamp] = '%m%d%Y%H%M%S' # MMDDYYYYHHMMSS
Date::DATE_FORMATS[:condensed_stamp] = '%m%d%Y%H%M%S' # MMDDYYYYHHMMSS

Time::DATE_FORMATS[:padded_stamp] = '%m/%d/%Y' # MM/DD/YYYY
Date::DATE_FORMATS[:padded_stamp] = '%m/%d/%Y' # MM/DD/YYYY

Time::DATE_FORMATS[:basic_datestamp] = "%-m/-%d/%Y %l:%M %p"
Date::DATE_FORMATS[:basic_datestamp] = "-%m/-%d/%Y %l:%M %p"

module DateHelperMethods
  def prior_end_of_quarter(offset)
    date = Date.current << (offset * 3)
    date.end_of_quarter
  end
end

class Date
  extend DateHelperMethods
  include DateHelperMethods
end

class DateTime
  extend DateHelperMethods
  include DateHelperMethods
end

class Time
  extend DateHelperMethods
  include DateHelperMethods
end