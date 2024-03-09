require 'base64'
class KriptoController < ApplicationController
  def process_kripto 
    session.delete(:result) if session[:result].present?
    session.delete(:result_base64) if session[:result_base64].present?
    input_text = case params[:input_type] 
                  when 'text' 
                    params[:text]
                  when 'file' 
                    params[:file].read if params[:file].present?
                  end



    if params[:button_pressed] == 'encrypt'
      @result = Kripto.encrypt(input_text, params[:mode], params[:key])
      @result_base64 = Base64.encode64(@result)
      session[:mode] = params[:mode]
      session[:action] = 'encrypt'
      if params[:input_type] == 'file'
        session[:extension] = File.extname(params[:file].original_filename)
      end
    elsif params[:button_pressed] == 'decrypt'
      @result = Kripto.decrypt(input_text, params[:mode], params[:key])
      @result_base64 = Base64.encode64(@result)
      session[:mode] = params[:mode]
      session[:action] = 'decrypt'
    end 
    if @result.blank?
      redirect_to root_path
    else 
      # Get file extension
      original_ext = File.extname(params[:file].original_filename) if params[:file].present?
      # Generate unique file name
      temp_filename = "kripto_#{SecureRandom.hex(10)}--ext--#{original_ext}"

      file_path = Rails.root.join('tmp', temp_filename)

      # Store file temporarily
      File.binwrite(file_path, @result)
      session[:result_path] = file_path.to_s

      render 'index' 
    end
  end

  def download_result
    result_path = session[:result_path]
  
    if File.exist?(result_path)
      if session[:action] == 'decrypt'
        filename = "decrypted_file#{session[:extension]}"
        
      elsif session[:action] == 'encrypt'
        encrypt_extension = params[:format] == 'binary' ? '.bin' : '.txt'
        filename = "encrypted_file#{encrypt_extension}"
      end

      
      content_type = determine_content_type(session[:cipher_type], params[:format])
  
      # Read the data from the file
      file_data = File.binread(result_path)
  
      # Send the data as a download
      send_data file_data, filename: filename, type: content_type

      File.delete(result_path)
    else
      render plain: "No result detected"
    end
  end

  def determine_content_type(cipher, format)
    if format == 'binary'
      'application/octet-stream'
    else
        'text/plain'
    end
  end
end
