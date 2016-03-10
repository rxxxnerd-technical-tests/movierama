class VoteMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def vote_notification(movie_id, voting_user_id, like_or_hate)
    @movie = Movie[movie_id]
    @voting_user = User[voting_user_id]

    @liked_or_hated = case like_or_hate
                        when 'like' then "liked"
                        when 'hate' then "hated"
                        else raise
                      end

    mail(to: @movie.user.email, subject: "#{@voting_user.name} #{@liked_or_hated} '#{@movie.title}'") do |f|
      f.text
    end
  end
end
