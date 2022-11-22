# frozen_string_literal: true

class MatchChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:match_id].present?

    stream_from "match_channel_#{params[:match_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
