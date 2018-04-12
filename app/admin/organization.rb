ActiveAdmin.register Organization do
  menu priority: 3
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :problem, :description, :website,
                :address, :email, :user_is_a_representative,
                :accepted?, :user_id, :tag_list, :photo, :logo
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

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  before_update do |organization|
    if !organization.send('accepted?_was') && organization.accepted?
      MIXPANEL.track(organization.user_id, 'Organization Accepted',
                     content: organization.class.to_s,
                     name: organization.name,
                     address: organization.address,
                     website: organization.website)
    end
  end

  form title: 'Organization' do |_|
    inputs 'Details' do
      input :photo, as: :formtastic_attachinary
      input :logo, as: :formtastic_attachinary
      input :name
      input :problem, as: :text
      input :description, as: :text
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
