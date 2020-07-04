# typed: false
class Note < ApplicationRecord

  before_save :validate_note_subject_max
  before_save :validate_note_body_max
  before_save :ensure_not_blank
  before_save :ensure_title

  belongs_to :user

  private

  def validate_note_subject_max
    raise ActiveRecord::RecordInvalid.new(self), 'Subject is more than 30 characters' if subject.length > 30
  end

  def validate_note_body_max
    raise ActiveRecord::RecordInvalid.new(self), 'Body is more than 1000 characters' if body.length > 1000
  end

  def ensure_not_blank
    raise ActiveRecord::RecordInvalid.new(self), 'Note cannot be blank' if subject == '' && body == ''
  end

  def ensure_title
    self.subject = body[0..29] if subject == ''
  end

end
