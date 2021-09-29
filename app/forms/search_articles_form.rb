class SearchArticlesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category_id, :integer
  attribute :author_id, :integer
  attribute :tag_id, :integer
  attribute :title, :string
  attribute :body, :string

  def search
    relation = Article.distinct # 重複するArticleを１つにまとめる

    relation = relation.by_category(category_id) if category_id.present? # categoryの検索機能
    relation = relation.by_author(author_id) if author_id.present? # authorの検索機能
    relation = relation.by_tag(tag_id) if tag_id.present? # tagの検索機能
    title_words.each do |word|
      relation = relation.title_contain(word) # タイトルの検索機能
    end
    body_words.each do |word|
      relation = relation.body_contain(word) # 本文の検索機能
    end
    relation
  end

  private

  def title_words
    title.present? ? title.split(nil) : [] # 空白ごとにキーワードを分割する
  end

  def body_words
    body.present? ? body.split('') : [] # １文字ごとにキーワードを分割する
  end
end
