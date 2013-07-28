atom_feed do |feed|
    feed.title("My great blog!")
    feed.updated(@posts[0].created_at) if @posts.length > 0
    @posts.each do |post|
        feed.entry(post) do |entry|
            entry.title(post.title)
            entry.content(post.contents, type: 'html')
        end
    end
end