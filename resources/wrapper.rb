actions :create, :delete
#default_action :create

attribute :keystring, :kind_of => String
attribute :keyfile, :kind_of => String
attribute :user, :kind_of => String, :default => "root"
