ActiveAdmin.register Article do
  menu priority: 5
  permit_params :title, :body, :category,
                :user_id, :photo, :description,
                :is_main_article, :is_published, :tag_list
  index do
    selectable_column
    column :id
    column :title
    column 'description' do |x|
      x.description.slice(0, 100)
    end
    column 'body' do |x|
      x.body.slice(0, 100)
    end
    column :category
    column :user_id
    column :is_main_article
    column :is_published
    column :tag_list
    actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  form title: 'Article' do |_|
    inputs 'Details' do
      input :user_id, as: :select, collection: User.where(admin: true)
      input :photo, as: :formtastic_attachinary
      input :title
      input :description, as: :string
      input :body, input_html: { class: 'tinymce' }
      input :is_published
      input :is_main_article
      input :tag_list, as: :select, collection: ActsAsTaggableOn::Tag.pluck(:name, :name)
    end
    para 'Press cancel to return to the list without saving.'
    actions
  end
end
