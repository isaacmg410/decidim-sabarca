# frozen_string_literal: true
module Decidim
  module Sabarca
    module Abilities
      # Defines the abilities related to sabarca for a logged in process admin user.
      # Intended to be used with `cancancan`.
      class ProcessAdminUser
        include CanCan::Ability

        attr_reader :user, :context

        def initialize(user, context)
          return unless user && !user.role?(:admin)

          @user = user
          @context = context

          # can :manage, SomeResource
        end

        private

        def current_settings
          context.fetch(:current_settings, nil)
        end

        def feature_settings
          context.fetch(:feature_settings, nil)
        end

        def current_feature
          context.fetch(:current_feature, nil)
        end

        def participatory_processes
          @participatory_processes ||= Decidim::Admin::ManageableParticipatoryProcessesForUser.for(@user)
        end
      end
    end
  end
end
