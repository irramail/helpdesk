class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    2.times { @answer.attachments.build }
  end

  # GET /answers/1/edit
  def edit
    2.times { @answer.attachments.build }
  end

  # POST /answers
  # POST /answers.json
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @answer = @ticket.answers.create(answer_params.merge(:user_id => current_user.id))

    #@answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @ticket, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:text, :user_id, :attachment_id, :ticket_id, attachments_attributes: [:id, :attachable, :filename])
    end
end
