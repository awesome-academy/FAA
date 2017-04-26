class ArraySpliter
  class << self
    def split_array posts_array
      split_length = Settings.education.posts.category_split_length
      if posts_array.length >= split_length
        [posts_array[0..split_length - 1],
          posts_array[split_length..posts_array.length]]
      else
        [posts_array[0..posts_array.length], nil]
      end
    end
  end
end
