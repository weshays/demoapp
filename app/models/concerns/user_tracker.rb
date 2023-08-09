module UserTracker
  extend ActiveSupport::Concern

  included do
    belongs_to :creator, class_name: 'User' # , optional: true, inverse_of: :user_trackers

    validates :creator_id, presence: { message: 'Creator ID not set' }
  end
end
