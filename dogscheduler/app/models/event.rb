# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  type        :string
#  start_time  :datetime
#  end_time    :datetime
#  food        :string
#  location    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :schedule
  validates :schedule_id, :event_type, :start_time, :end_time, presence:true
  validate :end_after_start
  validate :check_no_overlap

  private
  def end_after_start
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def check_no_overlap
    events = Event.all << self
    # conflict is true if any overlap
    conflict = events.sort_by(&:start_time).each_cons(2).any? do |a, b|
      a.end_time > b.start_time
    end
    errors.add(:start_time, "Events must not overlap") if conflict
  end
end
