require 'rails_helper'

describe ArticleMailer do

  describe '#report_summary' do
    subject(:mail) do
      described_class.report_summary.deliver_now
      ActionMailer::Base.deliveries.last
    end

    context 'when send_mail' do
      it { expect(mail.from.first).to eq('notifications@example.com') }
      it { expect(mail.to.first).to eq('admin@example.com') }
      it { expect(mail.subject).to eq('公開済記事の集計結果') }
      it { expect(mail.body).to match(/公開済の記事数/) }
    end
  end
end
