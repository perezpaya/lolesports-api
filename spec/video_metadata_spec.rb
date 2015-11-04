describe VideoMetadata do

  before do
    @video_metadata = VideoMetadata.new('XsLRHwosqnY')
  end

  it "can retrive title" do
    @video_metadata.title.class.must_equal String
  end

  it "can retrive author" do
    @video_metadata.author.must_equal "Spinnin' Records"
  end

  it "can get video date" do
    @video_metadata.published_at.year.must_equal 2015
    @video_metadata.published_at.month.must_equal 10
  end

  it "has more than 10k plays" do
    @video_metadata.plays.must_be :>, 10000
  end

end
