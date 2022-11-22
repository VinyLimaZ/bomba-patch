# frozen_string_literal: true

class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel_#{params[:match_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
