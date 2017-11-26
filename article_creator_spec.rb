describe "ArticleCreator" do
  it "#create_article works correctly" do
    placeholder_template = { id: 4 }
    allow_any_instance_of(RemoteServerAdapter).to receive(fetch_article_template).and_return(placeholder_template)
    allow_any_instance_of(RemoteServerAdapter).to receive(notify_template_error).and_return({ status: :ok })

    article_params = {
      title: "I love Dependency Injection",
      body: "Every time you don't use DI, a cute puppy dies.",
      author: "Unknown"
    }

    creator = ArticleCreator.new
    article = creator.create_article(article_params)
    expect(article.persisted?).to be(true)
    expect(article.author).to be("Unknown")
  end
end
