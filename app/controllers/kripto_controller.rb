require 'base64'
class KriptoController < ApplicationController
  before_action :reset_session_variables, only: :process_kripto
  after_action :clean_up_file, only: :download_result
  def process_kripto 
    input_data = fetch_input_data
    
    if params[:button_pressed] == 'encrypt'
      process_encryption(input_data)
    elsif params[:button_pressed] == 'decrypt'
      process_decryption(input_data)
    end 

    if @result.blank?
      redirect_to root_path
    else 
      prepare_file_download
      render 'index' 
    end
  end

  def download_result 
    result_path = session[:result_path]
    filename = determine_filename
    send_file_contents(result_path, filename, 'application/octet-stream')
  end 

  private 

  def string_to_binary(str)
    str.bytes.map { |b| b.to_s(2).rjust(8, '0')}.join
  end

  def result_to_utf8(binary_string)
    utf8_text = binary_string.scan(/.{8}/).map { |byte| byte.to_i(2) }.pack('C*')
    utf8_text.force_encoding('UTF-8')
  end 
  def reset_session_variables
    session.delete(:result)
    session.delete(:result_hex)
    session.delete(:result_path)
  end 
  def fetch_input_data 
    params[:input_type] == 'text' ? params[:text] : params[:file]&.read
  end

  def process_encryption(input_data)
    @init_binary = string_to_binary(input_data)
    @result = Kripto.encrypt(input_data, params[:mode], params[:key])
    @result_hex = @result.to_i(2).to_s(16)
    session[:mode] = params[:mode]
    session[:action] = 'encrypt'
  end
  def process_decryption(input_data)
    @init_binary = string_to_binary(input_data)
    @result = Kripto.decrypt(input_data, params[:mode], params[:key])
    @result_hex = @result.to_i(2).to_s(16)
    @result_utf8 = result_to_utf8(@result)
    session[:mode] = params[:mode]
    session[:action] = 'decrypt'
  end

  def prepare_file_download
    temp_filename = "kripto_#{SecureRandom.hex(10)}.bin"
    file_path = Rails.root.join('tmp', temp_filename)
    File.binwrite(file_path, @result)
    session[:result_path] = file_path.to_s
  end 

  def determine_filename
    session[:action] == 'decrypt' ? "decrypted_file.bin" : "encrypted_file.bin"
  end 

  def send_file_contents(result_path, filename, content_type)
    if File.exist?(result_path)
      send_data File.binread(result_path), filename: filename, type: content_type
    else 
      render plain: "No result detected"
    end 
  end 
  
  def clean_up_file
    result_path = session[:result_path]
    File.delete(result_path) if result_path && File.exist?(result_path)
  end 
end
