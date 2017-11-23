# Available:
# RemoteServerAdapter
#  #fetch_article_template
#  #notify_template_error

# Task:
# Retrieve Placeholder Template
# Create Article from Template

class ArticleCreator
  def create_article(article_params)
    placeholder_template = adapter.fetch_article_template
    article = Article.new(article_params)

    if valid?(article)
      article.save
    else
      adapter.notify_template_error
    end
  end

  def valid?
    # Very ugly Regex pattern matching
  end

  def adapter
    @adapter =|| RemoteServerAdapter.new
  end
end

describe "ArticleCreator" do
  it "creates article from placeholder template" do
    placeholder_template = { id: 4 }
    allow_any_instance_of(RemoteServerAdapter).to receive(fetch_article_template).and_return(placeholder_template)
    allow_any_instance_of(RemoteServerAdapter).to receive(notify_template_error).and_return({ status: :ok })

    article_params = {
      title: "I love Dependency Injection",
      body: "Every time you don't use DI, a cute puppy dies.",
      author: "Anonymous"
    }

    creator = ArticleCreator.new
    article = creator.create_article(article_params)
    expect(article.id).to be_defined
    expect(article.author).to be("Anonymous")
  end
end
