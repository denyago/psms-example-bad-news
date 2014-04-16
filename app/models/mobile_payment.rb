# Presents fact of user's payment via
# Mobile Payments API.
#
# See: http://developers.fortumo.com/mobile-payments-api/
class MobilePayment < BasePayment
  self.valid_request_params = %w{billing_type country currency keyword
                                 message message_id operator price price_wo_vat
                                 sender service_id shortcode sig status test
                                 }.uniq.freeze

  def successful?
    is_mo? && is_status_ok? || is_mt? && !is_status_failed? || is_test_mode?
  end

  def is_status_failed?
    @params[:status].to_s.downcase == 'failed'
  end

  def is_status_ok?
    @params[:status].to_s.downcase == 'ok'
  end

  def is_mo?
    @params[:billing_type].to_s.downcase == 'mo'
  end

  def is_mt?
    not is_mo?
  end
end
