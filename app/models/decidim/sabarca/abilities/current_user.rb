# frozen_string_literal: true
module Decidim
  module Sabarca
    module Abilities
      # Defines the abilities related to sabarca for a logged in user.
      # Intended to be used with `cancancan`.
      class CurrentUser
        include CanCan::Ability

        attr_reader :user, :context

        def initialize(user, context)
          return unless user

          @user = user
          @context = context

          # can :manage, SomeResource if authorized?(:some_action)
        end

        private

        def authorized?(action)
          return unless feature

          ActionAuthorizer.new(user, feature, action).authorize.ok?
        end

        def current_settings
          context.fetch(:current_settings, nil)
        end

        def feature_settings
          context.fetch(:feature_settings, nil)
        end

        def feature
          feature = context.fetch(:current_feature, nil)
          return nil unless feature && feature.manifest.name == :sabarca

          feature
        end
      end
    end
  end
end
