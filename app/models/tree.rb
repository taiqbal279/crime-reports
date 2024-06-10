require "rqrcode"
class Tree < ApplicationRecord
  include Rails.application.routes.url_helpers
  #
  # validations
  #

  validates_uniqueness_of :tree_id

  #
  # associations
  #

  has_one_attached :qr_image
  belongs_to :breed, optional: true
  belongs_to :garden, optional: true
  has_many :item_descriptions
  accepts_nested_attributes_for :item_descriptions, allow_destroy: true, :reject_if => lambda { |a| a['item_name'].blank? }
  attr_accessor :is_cattle
  #
  # Callbacks
  #

  after_create :generate_qr

  #
  # instance methods
  #

  def qr_image_url(size = :normal)
    if qr_image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(qr_image, only_path: true)
    else
      ''
    end
  end

  def generate_qr
    url_term = (self.is_cattle == true) ? 'items' : 'trees'
    puts url_term

    qrcode = RQRCode::QRCode.new(APPLICATION_CONFIG['BASE_URL'] + "/#{url_term}/#{self.id.to_s}")

    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: false,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 160
    )

    # IO.binwrite("/tmp/#{self.tree_id}.png", png.to_s)
    puts png.to_s.inspect
    puts "-------------------"
    self.qr_image.attach(io: StringIO.new(png.to_s), filename: "#{self.tree_id}.png")
    puts Rails.application.routes.url_helpers.inspect
    if self.qr_image.attached?
      puts Rails.application.routes.url_helpers.rails_blob_path(self.qr_image, only_path: true).inspect
      Rails.application.routes.url_helpers.rails_blob_path(self.qr_image, only_path: true)
    else
      ''
    end
  end

end
