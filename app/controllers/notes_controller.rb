class NotesController < ApplicationController
  before_action :load_note, only: [:show, :destroy]

	def index
    @notes = Note.desc(:created_at).page(params[:page]).per(10)
	end

  def show 
    prepare_meta_tags(title: @note.title,
                      description: @note.text,
                      keywords: @note.keywords)
  end

  def edit
    @note = Note.find(params[:id])
    @page_title       = 'Member Login'

  end

  def create

    @note = Note.new(
                      title: $xvars["form_note"]["title"],
                      text: $xvars["form_note"]["text"],
                      keywords: $xvars["form_note"]["keywords"],
                      body: $xvars["form_note"]["body"],
                      user_id: $xvars["user_id"])
    @note.save!
      # if @note.save!
      #   format.html { redirect_to @note, notice: 'Sample was successfully created.'  }
      #   format.json { render :show, status: :created, location: @note }
      # else
      #   format.html { render :new }
      #   format.json { render json: @note.errors, status: :unprocessable_entity }
      # end
      redirect_to @note

  end

  def my
    @notes = Note.where(user_id: current_ma_user).desc(:created_at).page(params[:page]).per(10)
    @page_title       = 'My Notes'
  end

  def update
    # $xvars["select_note"] and $xvars["edit_note"]
    # These are variables.
    # They contain everything that we get their forms select_note and edit_note
    note_id = $xvars["select_note"] ? $xvars["select_note"]["title"] : $xvars["p"]["note_id"]
    @note = Note.find(note_id)
    @note.update(title: $xvars["edit_note"]["note"]["title"],
                    text: $xvars["edit_note"]["note"]["text"],
                    keywords: $xvars["edit_note"]["note"]["keywords"],
                    body: $xvars["edit_note"]["note"]["body"])
    redirect_to @note


  end

  def destroy
    if Rails.env.test? #Temp solution until fix test of current_ma_user
      current_ma_user = $xvars["current_ma_user"]
      #current_ma_user = @note.user
    end
    if current_ma_user.role.upcase.split(',').include?("A") || current_ma_user == @note.user
      @note.destroy
    end
      redirect_to :action=>'index'
  end

  private

  def load_note
    @note = Note.find(params[:id])
  end


end
