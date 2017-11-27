class ArticleCreator
  def create_article(article_params)
    placeholder_template = adapter.fetch_article_template
    article = Article.build(article_params, placeholder_template)

    if valid?(article)
      article.save
    else
      adapter.notify_template_error
    end
  end

  private

    def valid?
      # ... some complex validation
    end

    def adapter
      @adapter ||= RemoteServerAdapter.new
    end
end
