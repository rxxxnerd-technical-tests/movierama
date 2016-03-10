require 'rails_helper'

RSpec.describe VoteMailer do
  describe "#vote_notification" do
    let(:creator) { User.create(uid: 'null|12345', name: 'Creator', email: 'creator@test.host') }
    let(:movie) { Movie.create(title: 'Shrek', description: '', date: '2001-04-22', user: creator) }

    let(:voting_user) { User.create(uid: 'null|11111', name: 'Voting User', email: 'voting@test.host') }

    it "delivers an email" do
      expect {
        VoteMailer.vote_notification(movie.id, voting_user.id, 'like').deliver
      }.to change(ActionMailer::Base, :deliveries)
    end

    it "is addressed to the movie's creator" do
      message = VoteMailer.vote_notification(movie.id, voting_user.id, 'like')
      expect(message.to).to include creator.email
    end


    context "when someone likes the movie" do
      let(:liked_or_hated) { 'like' }

      it "congratulates the user" do
        message = VoteMailer.vote_notification(movie.id, voting_user.id, liked_or_hated)

        expect(message.body).to match /Another successful recommendation/
      end
    end

    context "when someone hates the movie" do
      let(:liked_or_hated) { 'hate' }

      it "suggests the user should make another recommendation" do
        message = VoteMailer.vote_notification(movie.id, voting_user.id, liked_or_hated)

        expect(message.body).to match /Maybe try recommending another film/
      end
    end
  end
end
