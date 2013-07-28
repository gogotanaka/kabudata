# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://tousijyohou.jp"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  #
  # index page
  add blogs_path
  add boards_path
  add boards_path

  add stock_index_path
  add list_boards_path
  add page_piece_path
  add welcome_index_path
  add page_regulation_path
  add page_consultant_path
  add page_brokerage_path
  add page_inquiry_path
  add page_rise_path
  add page_sitemap_path

  # show page
  Blog.find_each do |blog|
    add blogs_path(blog), :lastmod => blog.updated_at
  end
  Board.find_each do |board|
    add boards_path(board), :lastmod => board.updated_at
  end
  Stock.find_each do |stock|
    add stock_path(stock), :lastmod => stock.updated_at
  end
end
