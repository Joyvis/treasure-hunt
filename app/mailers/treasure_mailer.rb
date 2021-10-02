# frozen_string_literal: true

class TreasureMailer < ApplicationMailer
  def position_email
    @latitude = ENV['TREASURE_LATITUDE']
    @longitude = ENV['TREASURE_LONGITUDE']

    mail(
      to: params[:email],
      subject: 'Treasure Position'
    )
  end

  def found_email
    @treasure_finder_count = params[:treasure_finder_count]

    mail(
      to: params[:email],
      subject: 'Treasure Found'
    )
  end
end
