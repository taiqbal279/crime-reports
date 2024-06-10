require 'zip/zip'
require 'zip/zipfilesystem'
ActiveAdmin.register Tree do
  # permit_params :garden, :breed, :tree_id, :breed_name, :breed_desc, :garden_desc, :description, :flowering_period, :fertilization, :harvesting_period,
  #               :packaging_period, :parcel_period, :delivery_period, :image
  permit_params :tree_id, :breed_name, item_descriptions_attributes: [:id, :item_name, :description, :_destroy, images: []]

  batch_action :download_image do |id|
    tree = Tree.find_by_id(id)
    send_data(tree.qr_image.download, :type => 'application/image', :filename => "#{tree.tree_id}.png")
  end

  # batch_action :download_all_qr do |ids|
  #   @trees = []
  #   batch_action_collection.find(ids).each do |t|
  #     @trees.append(t)
  #   end
  #   @qr_images = []
  #   @trees.each do |tree|
  #     # @qr_images.append(File.open(ActiveStorage::Blob.service.send(:path_for, Tree.last.qr_image.attachment.blob.key)))
  #     @qr_images.append(tree.qr_image.attachment)
  #     # send_data(tree.qr_image.download, :type => 'application/image', :filename => "#{tree.tree_id}.png")
  #   end
  #
  #   t = Tempfile.new(['qr_codes', '.zip'], Rails.root.join('tmp'))
  #   Zip::ZipOutputStream.open(t.path) do |zos|
  #     @trees.each do |tree|
  #       zos.put_next_entry(File.open('qr_codes', 'wb') { |f| f.write(Base64.decode64(tree.qr_image.attachment.blob.key)) })
  #     end
  #   end
  #
  #   # Tree.last.qr_image.download
  #   # send_data(Tree.last.qr_image.download, :type => 'application/zip', :filename => "qr_codes.zip") if @qr_images.present?
  #   send_file(t.path, :type => 'application/zip', :filename => "qr_codes.zip") if @qr_images.present?
  # end

  index do
    panel 'QR Download Instruction' do
      "QR image can be downloaded by selecting a single object from index and calling download image method from
      batch actions or by right clicking on the QR image and then 'save as image'"
    end
    selectable_column
    id_column
    column :tree_id
    column :breed_name
    column :qr_image do |tree|
      image_tag tree.qr_image_url, style: 'width: 256px; height: 256px'
    end
    actions
  end

  filter :tree_id
  filter :breed_name

  show do
    attributes_table do
      row :tree_id
      row :breed_name
      row :item_descriptions do |t|
        table_for t.item_descriptions do
          column do |i|
            i.item_name + ' : ' + i.description.html_safe
          end
        end
      end
      row :qr_image do |tree|
        image_tag tree.qr_image_url, style: 'width: 256px; height: 256px'
      end
    end
  end

  # item_desc_array format
  form do |f|
    f.inputs do
      input :tree_id
      input :breed_name
      f.has_many :item_descriptions, allow_destroy: true do |i|
        i.input :item_name
        i.input :description, as: :ckeditor
        i.input :images, as: :file, input_html: { multiple: true }
      end
    end
    f.actions
  end

  # attribute format
  # form do |f|
  #   f.inputs do
  #     # input :breed
  #     # input :garden
  #     input :tree_id
  #     input :breed_name
  #     input :breed_desc, as: :ckeditor
  #     input :garden_desc, as: :ckeditor
  #     input :description, as: :ckeditor
  #     input :flowering_period
  #     input :fertilization, as: :ckeditor
  #     input :harvesting_period
  #     input :packaging_period
  #     input :parcel_period
  #     input :delivery_period
  #     input :image, as: :file
  #   end
  #   f.actions
  # end

end