class Tweet < ActiveRecord::Base
    
    before_validation :link_check, on: :create
    
    belongs_to :user
    
    has_many :tweet_tags
    has_many :tags, through: :tweet_tags
    
    validates :message, presence: true, length: {maximum: 280, too_long: "A tweet is 280 characters, max. Everybody knows that!"}
    after_validation :apply_link, on: :create
    
    def link_check
        if self.message.include?("http://")
            check = true
        elsif self.message.include?("https://")
            check = true
        else
            check = false
        end
        if check == true
            array = self.message.split
            
            index = array.map{ |word| word.include?("http")}.index(true)
            self.link = array[index]
            if array[index].length > 23
                array[index] = "#{array[index][0..20]}..."
            end
            self.message = array.join(" ")
        end
    end
    
    def apply_link
        array = self.message.split
        index = array.map{ |word| word.include?("http://") || word.include?("https://")}.index(true)
    
        if index
            url = array[index]
            array[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
        end 
        self.message = array.join(" ")
    end
    
end
