require 'feedzirra'
require 'nokogiri'
require 'open-uri'
class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    
    begin
      page = open(params[:url])
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read)
    @blog = Blog.new(url: params[:url], title: html.css('title')[0].content, describe: html.css('meta').select{|x| x[:name] == "description" || x[:name] == "Description"}[0][:content])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(params[:blog])

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  def count_in
    ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    blog = Blog.find(params[:id])
    unless blog.ins.find_by_ip(ip)
      blog.ins.create(ip: ip)
      blog.in = blog.in + 1
      blog.save
    end
    redirect_to blog_path(blog)
  end

  def out
    blog = Blog.find(params[:id])
    blog.out = blog.out + 1
    blog.save
    redirect_to blog.url
  end

end
