# frozen_string_literal: true

Rails.application.routes.draw do
  post '/download', to: 'download#create'
end
