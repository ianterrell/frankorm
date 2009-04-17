require '../../objc-generators/frankorm-gen'

class Objects < FrankORMGenerator
  project_name "Feedcloud"
  directory "/Users/ian/src/feedcloud"
  author "Ian Terrell"
  
  frank_object :user do |user|
    user.string :username
    user.string :password
    user.number :awesomeness_code
    user.belongs_to :group
    user.has_many :opinions
  end
  
  frank_object :group do |group|
    group.string :name
    group.has_many :users
  end
  
  frank_object :opinion do |opinion|
    opinion.string :value
    opinion.belongs_to :user
  end
end  
