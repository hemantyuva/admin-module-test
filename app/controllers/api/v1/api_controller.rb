module Api
  module V1
    class ApiController < ApplicationController
      protect_from_forgery with: :null_session 
      rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
      # rescue_from PG::ForeignKeyViolation, :with => :record_not_found

      #response message to all pages for api 
      def response_message message, code
        render json: {message: message, code: code}
      end

      #pagination for apis 
      def pages_message current_page ,all_pages 
        {current_page: current_page,page_size: ENV['SIZE'],total_pages: all_pages} 
      end

      private
      def record_not_found(error)
        render :json => {:message => "Record not found", code: 401 }, :status => :not_found and return
      end
    end
  end
end
