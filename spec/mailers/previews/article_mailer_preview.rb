# Preview all emails at http://localhost:3000/rails/mailers/article_mailer
class ArticleMailerPreview < ActionMailer::Preview
  ArticleMailer.report_summary
end
