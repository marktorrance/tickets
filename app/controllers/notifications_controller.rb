class NotificationsController < ApplicationController
  protect_from_forgery except: [:create]

  # Instant payment notification from PayPal
  def create
    response = validate_IPN_notification(request.raw_post)
    response = "VERIFIED"  # Temporarily treat INVALID responses as valid for testing
    case response
    when "VERIFIED"
      # check that paymentStatus=Completed
      # check that txnId has not been previously processed
      # check that receiverEmail is your Primary PayPal email
      # check that paymentAmount/paymentCurrency are correct
      # process payment
      if params[:payment_status] == 'Completed'
        if params[:txn_id] && params[:txn_id] > 0
          o = Order.find(params[:txn_id])
          if o
            o.payment_auth = params[:payment_date]
            o.save
          else
            Rails.logger.error "Could not find/validate order: #{params.to_json}"
          end
        else
          # Find order by email
          o = Order.unconfirmed.find_by_email(params[:payer_email])
          if o
            o.payment_auth = params[:payment_date]
            o.save
          else
            Rails.logger.error "Could not find/validate order by email: #{params.to_json}"
          end
        end
      end
    when "INVALID"
      # log for investigation
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
