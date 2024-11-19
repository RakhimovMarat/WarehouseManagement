# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_created(order)
    @order = order
    mail to: 'mf.rakhimov1982@gmail.com',
         subject: 'Создан новый заказ'
  end
end
