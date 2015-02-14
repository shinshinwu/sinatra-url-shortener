class Url < ActiveRecord::Base

  belongs_to :user

  before_validation :generate_slug

  private

    def generate_slug
      random_key = Array.new(6){rand(36).to_s(36)}.join
      self.slug = "#{random_key}"
    end
end
