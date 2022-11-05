class Testmailer < ApplicationMailer
  default from: "noreply@helpdesk.zeetway.net"

  default define_method: :smtp

  def create_mail(link, name, mail, id, text)
    mixed = mail(
        from: 'noreply@helpdesk.zeetway.net',
        to: mail,
        subject: "Ticket #{name}[#{id}]"
    ) do |format|
      format.html { render inline: "#{text}<br />#{link}".html_safe }
    end

  end
end
