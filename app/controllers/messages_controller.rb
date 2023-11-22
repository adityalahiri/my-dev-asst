require 'net/http'

class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def invoke_llm
        puts "invoke_llm is called" # Debug statement
        @response = send_test_request
        # ... other code for this action
      end
    def index 
        puts "In index"
        @messages = Message.all 
        @new_message = Message.new
      end
    def new
        @message = Message.new
    end
    def create 
        @message = Message.new(message_params) 
        if @message.save 
          redirect_to '/messages' 
        else 
          render :index
        end 
    end 
    private 
    def message_params 
        params.require(:message).permit(:content) 
    end
    
    
      private
    
      def send_test_request
        puts "send test is called" # Debug statement
        uri = URI('http://localhost:1234/v1/chat/completions')
        http = Net::HTTP.new(uri.host, uri.port)
        headers = { 'Content-Type' => 'application/json' }
        request_body = {
          messages: [
            { role: 'system', content: 'Always answer in rhymes.' },
            { role: 'user', content: 'Introduce yourself.' }
          ],
          temperature: 0.7,
          max_tokens: -1,
          stream: false
        }
    
        request = Net::HTTP::Post.new(uri, headers)
        request.body = request_body.to_json
    
        response = http.request(request)
        response.body
      rescue => e
        e.message
      end
end
