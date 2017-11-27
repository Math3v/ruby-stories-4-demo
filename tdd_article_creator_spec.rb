class RemoteServerAdapterMock
  def fetch_article_template
    { id: 4 }
  end

  def notify_template_error
    { status: :ok }
  end
end

desribe "ArticleCreator" do
  context "RemoteServer" do

    before do
      adapter_mock = RemoteServerAdapterMock.new
      @creator = ArticleCreator.new(adapter_mock)
    end

    it "creates article from placeholder template" do
      article_params = {
        title: "I love Dependency Injection",
        body: "Every time you don't use DI, a cute puppy dies.",
        author: "Unknown"
      }

      article = @creator.call(article_params)
      expect(article.persisted?).to be(true)
      expect(article.author).to be("Unknown")
    end
  end
end
