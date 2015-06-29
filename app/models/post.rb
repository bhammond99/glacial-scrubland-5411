class Post < ActiveRecord::Base
	has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"},
	:storage => :s3,
	:s3_credentials => Proc.new{|a| a.instance.s3_credentials }
	validates_attachment_content_type :image, content_type:  /\Aimage\/.*\Z/
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true
	is_impressionable 

	def s3_credentials
		{:bucket => ENV["S3_BUCKET_NAME"], :access_key_id => ENV["AWS_ACCESS_KEY_ID"], 
        :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
    end

	after_save :send_posts

	def send_posts
		logger.info "*****************Going to send posts: #{title}"
	end	
end
