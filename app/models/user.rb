class User < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :projects, :through => :works

  validates :fname, presence: true,
                    length: { minimum: 2 }
  validates :lname, presence: true,
                    length: { minimum: 5 }
  validates :company, presence: true  

  def name
    "#{fname} #{lname}"
  end
end
