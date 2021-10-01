# frozen_string_literal: true

class TreasureMailer < ApplicationMailer
  def position_email
    @latitude = ENV['TREASURE_LATITUDE']
    @longitude = ENV['TREASURE_LONGITUDE']

    mail(
      to: 'jjs276@gmail.com',
      subject: 'Treasure Position'
    )
  end
end
