ActiveAdmin.register CommunityArea do
  actions :all, :except => [:new, :create, :destroy]
  menu parent: 'Crime Analysis'

  config.paginate = false

  index do
    selectable_column
    id_column
    column :name
  end

  show do
    attributes_table do
      row :id
      row :name
    end
  end
end