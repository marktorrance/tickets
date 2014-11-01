class NotificationsController < ApplicationController
  protect_from_forgery except: [:create]

  # Instant payment notification from PayPal
  def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      # check that paymentStatus=Completed
      # check that txnId has not been previously processed
      # check that receiverEmail is your Primary PayPal email
      # check that paymentAmount/paymentCurrency are correct
      # process payment
      if params[:payment_status] == 'Completed'
        if params[:txn_id] && params[:txn_id].to_i > 0
          begin
            o = Order.find(params[:txn_id])
            o.payment_auth = params[:payment_date]
            o.save
          rescue => e
            Rails.logger.error "Could not find/validate order: #{params.to_json} #{e.message}"
          end
        elsif params[:payer_email]
          # Find order by email
          begin
            o = Order.unconfirmed.find_by_email(params[:payer_email])
            o.payment_auth = params[:payment_date]
            o.save
          rescue => e
            Rails.logger.error "Could not find/validate order by email: #{params.to_json} #{e.message}"
          end
        else
          Rails.logger.error params.to_json
        end
      end
    when "INVALID"
      # log for investigation
      Rails.logger.error "INVALID: #{params.to_json}"
    else
      # error
    end
    render :nothing => true
  end

  protected

  def validate_IPN_notification(raw)
    uri = URI.parse('https://www.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw,
                         'Content-Length' => "#{raw.size}",
                         'User-Agent' => "Peninsulaires Payment System"
                       ).body
  end

end
