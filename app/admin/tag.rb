ActiveAdmin.register ActsAsTaggableOn::Tag do
  menu priority: 6
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  form title: 'A custom title' do |_|
    inputs 'Details' do
      input :name
    end
    para 'Press cancel to return to the list without saving.'
    actions
  end
end
