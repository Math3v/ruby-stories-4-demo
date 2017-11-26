class ArticleCreator
  def initialize(adapter)
    @adapter = adapter || RemoteServerAdapter.new
  end

  def call(article_params)
    placeholder_template = @adapter.fetch_article_template
    article = Article.new(article_params)

    if valid?(article)
      article.save
    else
      @adapter.notify_template_error
    end
  end

  private

    def valid?
      # Very ugly Regex pattern matching
    end
end
