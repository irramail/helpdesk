class ApiController < ApplicationController
  skip_before_action  :verify_authenticity_token
  def ticket
    return unless project=Project.where('link LIKE ?', "%#{URI(request.referer).host}%").first
    #URI(request.referer).host
    @ticket = Ticket.new
    @ticket.text = '';
    @ticket.text = params[:comment] if params[:comment].present?
    @ticket.text += " [[#{params[:email]}]]" if params[:email].present?
    @ticket.link = request.referer
    @ticket.project = project
    @ticket.status = Ticket::STATUS.index(:open)
    
    @ticket.attachments.build if params[:screenshot].present?
    @ticket.attachments.each_with_index do |a, i|

      screenshot = params[:screenshot]
      screenshot_index = screenshot.index('base64') + 7
      file_screenshot = screenshot.slice(screenshot_index, screenshot.length)
      decoded_screenshot = Base64.decode64(file_screenshot)

      filename = Dir::Tmpname.make_tmpname(['screenshot-', '.png'], i)
      fullname = "#{Rails.root}/tmp/#{filename}"

      # New temp file from base64
      file = File.new(fullname, "wb")
      file.write(decoded_screenshot)
      file.close

      # Carrierwave association
      File.open(fullname) do |f|
        a.filename = f
      end

      # Remove temp file
      File.unlink(fullname) if File.exist?(fullname)
    end

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    respond_to do |format|
      if @ticket.save
        @ticket.project.users.each do |user|

          begin
            msg = Testmailer.create_mail(ticket_path(@ticket, only_path: false), @ticket.project.name, user.email, @ticket.id, @ticket.text) #FIXME in ticket_path , protocol: 'https'
            msg.deliver_now

          rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
            p e.message
          end
        end
        #format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: {success: true}, status: :created}
      else
        #format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:text, :project_id, :category_id, :closed, :closed_at, :status, :link, attachments_attributes: [:id, :attachable, :filename])
  end
end