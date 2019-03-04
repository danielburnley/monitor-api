# frozen_string_literal: true

class UI::UseCase::ConvertUIFFProject
  def execute(project_data:)
    @project = project_data

    @converted_project = {}

    convert_infrastructures
    convert_summary
    convert_planning
    convert_land_owenership
    convert_procurement
    convert_demolition_and_remediation
    convert_milestones

    @converted_project
  end

  private

  def convert_infrastructures
    return if @project[:infrastructures].nil?

    @converted_project[:infrastructures] = @project[:infrastructures]
  end

  def convert_summary
    return if @project[:summary].nil?

    @converted_project[:summary] = @project[:summary]
  end

  def convert_planning
    return if @project[:planning].nil?

    @converted_project[:planning] = @project[:planning]
  end

  def convert_land_owenership
    return if @project[:landOwenership].nil?

    @converted_project[:landOwenership] = @project[:landOwenership]
  end

  def convert_procurement
    return if @project[:procurement].nil?

    @converted_project[:procurement] = @project[:procurement]
  end

  def convert_demolition_and_remediation
    return if @project[:demolitionRemediation].nil?

    @converted_project[:demolitionRemediation] = @project[:demolitionRemediation]
  end

  def convert_milestones
    return if @project[:milestones].nil?

    @converted_project[:milestones] = @project[:milestones]
  end
end
