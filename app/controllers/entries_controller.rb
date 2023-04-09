class EntriesController < ApplicationController
  def index
    @entries = Current.user.entries
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.entryable = Current.user
    if @entry.save
      flash[:success] = 'Record saved successfully'
      redirect_to entries_path
    else
      flash[:error] = @entry.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @entry = Current.user.entries.find(params[:id])
  end

  def update
    @entry = Current.user.entries.find(params[:id])
    if @entry.update(entry_params)
      flash[:success] = 'Record saved successfully'
      redirect_to entries_path
    else
      flash[:error] = @entry.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry = Current.user.entries.find(params[:id])
    if @entry.destroy
      flash[:success] = 'Record saved successfully'
    else
      flash[:error] = @entry.errors.full_messages
    end
    redirect_to entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :url, :username, :password, :password_confirmation, :note)
  end
end
