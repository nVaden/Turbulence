module CommentsHelper
	def time post
		time_ago_in_words(post.created.from_now)
	end
end
