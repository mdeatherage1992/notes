class NotesController < ApplicationController

  def new
    unless current_user
      redirect_to root_path
      flash[:alert] = 'Please Sign in to create note'
    end
    @new_note = Note.new(user_id: current_user.id)
  end

  def create
    new_note = Note.new(note_params)
    if new_note.save!
      flash[:success] = 'Successfully Created Note'
    else
      flash[:alert] = 'Unable to save note. Please try again'
    end
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => e
    redirect_to root_path
    flash[:alert] = 'ERROR: ' + e.message
  end

  def update_note
    note = Note.find(params[:id])
    if note
      note.update_attribute(params[:attribute].downcase.to_sym, params[:value])
      render json: {message: 'Note Saved' }, status: 200
    else
      render json: { message: 'Note note saved' }, status: 500
    end
  end

  def destroy
    Note.destroy(params[:id])

    if !Note.find_by(id: params[:id])
      flash[:success] = 'successfully destroyed note'
    else
      flash[:alert] = 'There was a problem deleting your note. Please try again.'
    end
    redirect_to root_path
  end

  private
  def note_params
    params.require(:note).permit(:user_id, :subject, :body)
  end
end
