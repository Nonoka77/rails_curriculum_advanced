namespace :article_summary do
  desc '毎日に管理者に総記事数と、昨日の記事数と内容をメールする'
  task mail_article_summary: :environment do
    ArticleMailer.report_summary.deliver_now
  end
end
