class ArticleCreator
  def initialize(adapter)
    @adapter = adapter || RemoteServerAdapter.new
  end

  def call(article_params)
    placeholder_template = @adapter.fetch_article_template
    article = Article.build(article_params, placeholder_template)

    if valid?(article)
      article.save
    else
      @adapter.notify_template_error
    end
  end

  private

    def valid?
      # ... some complex validation
    end
end
