class PagesController < ApplicationController

  def home
    @user_notes = Note.where(user_id: current_user&.id)
  end
end
