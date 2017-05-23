ActiveAdmin.register Comment do
  menu priority: 4
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :comment, :commentable_type, :commentable_id, :user_id
index do
    selectable_column
    column :id
    column :title
    column :comment
    column :commentable_type
    column :commentable_id
    column :user_id
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
