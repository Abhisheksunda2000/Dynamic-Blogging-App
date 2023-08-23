class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  require "razorpay"
  Razorpay.setup('rzp_test_bcBvcsCAo0QnhI', 'YmWdA6jo4UyfolwlkYuaR2iX')

  def create_payment
    amount = params[:amount]
    order = Razorpay::Order.create(amount: amount, currency: 'INR')
    render json: order
  end
  
  def confirm_payment
    payment_id = params[:order_id] # Use the order ID as payment_id
    razorpay_payment = Razorpay::Payment.fetch(payment_id)
    # Verify and process the payment
    # Update your database or grant access to the paid content
    render json: { message: 'Payment confirmed' }
  end
end
