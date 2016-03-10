require 'rails_helper'

RSpec.describe VotingBooth do
  let(:creator) { User.create(uid: 'null|12345', name: 'Creator', email: 'creator@test.host') }
  let(:movie) { Movie.create(title: 'Shrek', description: '', date: '2001-04-22', user: creator) }

  let(:voting_user) { User.create(uid: 'null|11111', name: 'Voting User', email: 'voting@test.host') }

  subject { VotingBooth.new voting_user, movie }

  describe "#vote" do
    before do
      @mailer = VoteMailer
      allow(VoteMailer).to receive(:delay) { @mailer }
    end

    context "when 'liking' a movie" do
      before do
        allow(@mailer).to receive(:vote_notification).with(movie.id, voting_user.id, 'like')
      end

      it "sends a notification to the creator" do
        subject.vote :like
      end
    end

    context "when 'hating' a movie" do
      before do
        allow(@mailer).to receive(:vote_notification).with(movie.id, voting_user.id, 'hate')
      end

      it "sends a notification to the creator" do
        subject.vote :hate
      end
    end
  end

end
