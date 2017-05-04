module Education::RecruitmentsHelper
  def related_recruitment_slice recruitments
    recruitments.each_slice(recruitments.length / Settings.slice.slice_num).to_a
  end
end
