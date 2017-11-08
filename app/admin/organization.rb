ActiveAdmin.register Organization do
  menu priority: 3
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :problem, :description, :website,
    :address, :email, :user_is_a_representative,
    :accepted?, :user_id, :tag_list
    index do
    selectable_column
    column :id
    column :name
    column :website
    column :email
    column :address
    column :created_at
    column :user_is_a_representative
    column :accepted?
    column :tag_list, as: :select, collection: ActsAsTaggableOn::Tag.pluck(:name, :name)
    actions
  end

  form title: 'Organization' do |_|
    inputs 'Details' do
      input :photo, as: :formtastic_attachinary
      input :name
      input :problem
      input :description
      input :website
      input :address
      input :user_is_a_representative
      input :email
      input :accepted?
      input :tag_list, as: :select, collection: ActsAsTaggableOn::Tag.pluck(:name, :name)
    end
    para 'Press cancel to return to the list without saving.'
    actions
  end

end

