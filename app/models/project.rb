class Project < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :users, :through => :works
  belongs_to :user

  validates :name, presence: true,
                   length: { minimum: 5 }
  validates :company, presence: true
  validates :default_rate, numericality: 
                           { only_integer: true,
                             greater_than_or_equal_to: 50,
                             less_than: 1000 }
  validates :slug, length: { minimum: 3 }                             
  validates :slug, uniqueness: true
  validates :user, presence: true

  scope :lowdefaultrate, -> { where("default_rate < 100")}

  def to_s
    "#{name} (#{company})"
  end

  def self.export_csv(projects)
    CSV.generate do |csv|
      #csv << column_names
      csv << ["name", "company", "default_rate", "created_at", "owner", "most recent work item"]
      projects.each do |project|
        #csv << project.attributes.values_at(*column_names)
        csv << [
          project.name,
          project.company.name,
          project.default_rate,
          project.created_at,
          project.user,
          project.works.order("created_at DESC").first ]
      end
    end
  end  
  
end
