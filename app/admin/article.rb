ActiveAdmin.register Article do
  menu priority: 5
  permit_params :title, :body, :category,
                :user_id, :photo, :description,
                :is_main_article, :is_published
  index do
    selectable_column
    column :id
    column :title
    column :description
    column :body
    column :category
    column :user_id
    column :is_main_article
    column :is_published
    actions
  end

  form title: 'A custom title' do |_|
    inputs 'Details' do
      input :user_id, as: :select, collection: User.where(admin: true)
      input :photo, as: :formtastic_attachinary
      input :title
      input :description
      input :body, input_html: { class: 'tinymce' }
      input :is_published
      input :is_main_article
    end
    para 'Press cancel to return to the list without saving.'
    actions
  end
end
