# frozen_string_literal: true

class UI::UseCases
  def self.register(builder)
    builder.define_use_case :ui_create_project do
      UI::UseCase::CreateProject.new(
        create_project: builder.get_use_case(:create_new_project)
      )
    end

    builder.define_use_case :ui_get_project do
      UI::UseCase::GetProject.new(
        find_project: builder.get_use_case(:find_project)
      )
    end

    builder.define_use_case :ui_update_project do
      UI::UseCase::UpdateProject.new(
        update_project: builder.get_use_case(:update_project)
      )
    end

    builder.define_use_case :ui_get_base_return do
      UI::UseCase::GetBaseReturn.new(
        get_base_return: builder.get_use_case(:get_base_return)
      )
    end

    builder.define_use_case :ui_create_return do
      UI::UseCase::CreateReturn.new(
        create_return: builder.get_use_case(:create_return)
      )
    end
  end
end
