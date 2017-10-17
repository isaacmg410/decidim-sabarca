module Decidim
  module Sabarca
    # Abstract class from which all models in this engine inherit.
    class MayorNeighborhood < Decidim::ApplicationRecord
      # include Decidim::Publicable
      belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"
      belongs_to :scope, foreign_key: "decidim_scope_id", class_name: "Decidim::Scope"


      validates :title, presence: true, uniqueness: { scope: :decidim_organization_id }
      validates :decidim_scope_id, presence: true
      validates :address, presence: true
      validates :slug, uniqueness: { scope: :decidim_organization_id }
      validates :slug, presence: true

      geocoded_by :address
      
      after_validation :geocode

    end
  end
end

  #
  # module Decidim
  #   # A UserGroup is an organization of citizens
  #   class UserGroup < ApplicationRecord
  #     belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"
  #
  #     has_many :memberships, class_name: "Decidim::UserGroupMembership", foreign_key: :decidim_user_group_id
  #     has_many :users, through: :memberships, class_name: "Decidim::User", foreign_key: :decidim_user_id
  #
  #     validates :name, presence: true, uniqueness: { scope: :decidim_organization_id }
  #     validates :document_number, presence: true, uniqueness: { scope: :decidim_organization_id }
  #     validates :phone, presence: true
  #     validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }
  #     validates :scope_id, presence: true
  #     validates :address, presence: true
  #     validate :correct_state
  #
  #     mount_uploader :avatar, Decidim::AvatarUploader
  #
  #     geocoded_by :address
  #
  #     after_validation :geocode
  #
  #     scope :verified, -> { where.not(verified_at: nil) }
  #     scope :rejected, -> { where.not(rejected_at: nil) }
  #
  #     # Public: Checks if the user group is verified.
  #     def verified?
  #       verified_at.present?
  #     end
  #
  #     # Public: Checks if the user group is rejected.
  #     def rejected?
  #       rejected_at.present?
  #     end
  #
  #     # Public: Checks if the user group is pending.
  #     def pending?
  #       verified_at.blank? && rejected_at.blank?
  #     end
  #
  #     private
  #
  #     # Private: Checks if the state user group is correct.
  #     def correct_state
  #       errors.add(:base, :invalid) if verified? && rejected?
  #     end
  #   end
  # end
