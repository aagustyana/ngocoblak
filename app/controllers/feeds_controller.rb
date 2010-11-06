class FeedsController < ApplicationController
  attr_accessor :client
  # GET /feeds
  # GET /feeds.xml
  def index
    @feeds = Feed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.xml
  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.xml
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.xml
  def create
    @feed = Feed.new(params[:feed])

    respond_to do |format|
      if @feed.save
        flash[:notice] = 'Feed was successfully created.'
        format.html { redirect_to(@feed) }
        format.xml  { render :xml => @feed, :status => :created, :location => @feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.xml
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        flash[:notice] = 'Feed was successfully updated.'
        format.html { redirect_to(@feed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_url) }
      format.xml  { head :ok }
    end
  end
  
  def ngocoblak
  end  
  
  def twitter_publish
    session[:feed_id] = params[:id]
    #if session[:access_token] and session[:access_secret]
    #  client = TwitterOAuth::Client.new(
    #    :consumer_key => TwitterConfig::CONSUMER_KEY,
    #    :consumer_secret => TwitterConfig::CONSUMER_SECRET,
    #    :token => session[:access_token],
    #    :secret => session[:access_secret]
    #  ) 
    #  status_update(client)
    #else    
      client = TwitterOAuth::Client.new(
        :consumer_key => TwitterConfig::CONSUMER_KEY,
        :consumer_secret => TwitterConfig::CONSUMER_SECRET
      )
      request_token = client.request_token
    
      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret
      redirect_to request_token.authorize_url #.gsub('authorize', 'authenticate')     
    #end
  end  
  
  def ngocoblak_publish
    client = TwitterOAuth::Client.new(
      :consumer_key => TwitterConfig::CONSUMER_NGOCOBLAK_KEY,
      :consumer_secret => TwitterConfig::CONSUMER_NGOCOBLAK_SECRET
    )
    request_token = client.request_token
  
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    NgocoblakComment.create(:content => params[:content],:status => true)
    redirect_to request_token.authorize_url  
  end  
  
  def twitter_callback
    client = TwitterOAuth::Client.new(
        :consumer_key => TwitterConfig::CONSUMER_KEY,
        :consumer_secret => TwitterConfig::CONSUMER_SECRET
    )
    access_token = client.authorize(
     session[:request_token],
     session[:request_token_secret] 
    )
    
    session[:access_token] = access_token.token
    session[:access_secret] = access_token.secret
    
    status_update(client)
  end  
  
  def ngocoblak_callback
    client = TwitterOAuth::Client.new(
        :consumer_key => TwitterConfig::CONSUMER_NGOCOBLAK_KEY,
        :consumer_secret => TwitterConfig::CONSUMER_NGOCOBLAK_SECRET
    )
    access_token = client.authorize(
     session[:request_token],
     session[:request_token_secret] 
    )
    
    session[:access_token] = access_token.token
    session[:access_secret] = access_token.secret
    
    ngocoblak_update(client)
    flash[:notice] = "ocehan anjeun tos lebet ka <a href='http://www.twitter.com'>twitter</a>, sok mangga dicek"
    redirect_to :action => "ngocoblak"   
  end  
  
  private
  def status_update(client)
    @feed = Feed.find(session[:feed_id])
    @feed.items.each_with_index do |item,idx|
      individual_update(item,client)
      break if idx>=9
    end  

    render :text=> "Your Items link has been published to twitter <br /> <a href='#{new_feed_url}'>Add more etsy feed</a>"  
  end  
  
  def individual_update(item,client)
    item.generate_permalink("bitly")  
    result = client.update("[TEST] New in my ETSY shop #{item.title} : $#{item.price} #{item.permalink}")
  end  
  
  def ngocoblak_update(client)
    
    result = client.update(NgocoblakComment.find(:first).content)
    NgocoblakComment.destroy_all
  end  
end
