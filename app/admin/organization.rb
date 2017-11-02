ActiveAdmin.register Organization do
  menu priority: 3
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, :problem, :description, :website, :address, :email, :user_is_a_representative, :accepted?, :user_id, :category
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
    actions
  end


#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end

