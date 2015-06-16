class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  
  def full_name
    "#{first_name} #{middle_name.to_s} #{last_name}"
  end

  def friendly_time
    updated_at.strftime("%B %d, %Y")
  end

  # def japanese_num
  #   "+81 + #{phone_number}"
  # end
  
  def group_list
    groups.pluck(:name).join(",")
  end

end
