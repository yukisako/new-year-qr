class MessagesController < ApplicationController
  def index
    @messages = Message.all.limit(10).order("created_at DESC")
    @msg = Message.last
    @message = Message.new
    unless @messages.length == 0
      str = (@msg.body + "\n\n" + @msg.name + "さんからのメッセージです").encode("Shift_JIS")
      qr = RQRCode::QRCode.new( str, :size => 10, :level => :h ).to_img
      qr.resize(200, 200).save("app/assets/images/test.png")
    end
  end

  def help
        @messages = Message.all
    @msg = Message.last
    @message = Message.new
    @size = @messages.length-1
    unless @size == -1
      str = (@msg.body + "\n" + @msg.name + "さんからのメッセージです").encode("Shift_JIS")
      qr = RQRCode::QRCode.new( str, :size => 10, :level => :h ).to_img
      qr.resize(200, 200).save("app/assets/images/test.png")
    end

  end

  def create 
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path, notice: 'メッセージを保存しました'
    else
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end 
  end

  def download
    file_name = "test.png"
    filepath = Rails.root.join('public',file_name)
    stat = File::stat(filepath)
    send_file(filepath, :filename => file_name, :length => stat.size)
  end


  private
  def message_params
    params.require(:message).permit(:name, :body)
  end

end
