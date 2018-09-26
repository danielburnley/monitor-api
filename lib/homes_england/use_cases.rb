# frozen_string_literal: true

class HomesEngland::UseCases
  def self.register(builder)
    builder.define_use_case :project_gateway do
      HomesEngland::Gateway::SequelProject.new(database: builder.database)
    end

    builder.define_use_case :template_gateway do
      HomesEngland::Gateway::InMemoryTemplate.new(template_builder:
                                                    builder.get_use_case(:template_builder) )
    end

    builder.define_use_case :template_builder do
      HomesEngland::Builder::Template::TemplateBuilder.new
    end

    builder.define_use_case :create_new_project do
      HomesEngland::UseCase::CreateNewProject.new(
        project_gateway: builder.get_use_case(:project_gateway)
      )
    end

    builder.define_use_case :find_project do
      HomesEngland::UseCase::FindProject.new(
        project_gateway: builder.get_use_case(:project_gateway)
      )
    end

    builder.define_use_case :update_project do
      HomesEngland::UseCase::UpdateProject.new(
        project_gateway: builder.get_use_case(:project_gateway)
      )
    end

    builder.define_use_case :get_schema_for_project do
      HomesEngland::UseCase::GetSchemaForProject.new(
        template_gateway: builder.get_use_case(:template_gateway)
      )
    end

    builder.define_use_case :populate_template do
      HomesEngland::UseCase::PopulateTemplate.new(
        template_gateway: builder.get_use_case(:template_gateway)
      )
    end

    builder.define_use_case :add_user do
      HomesEngland::UseCase::AddUser.new(
        user_gateway: builder.get_use_case(:users_gateway)
      )
    end

    builder.define_use_case :add_user_to_project do
      HomesEngland::UseCase::AddUserToProject.new(
        user_gateway: builder.get_use_case(:users_gateway)
      )
    end
  end
end
