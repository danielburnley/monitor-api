# frozen_string_literal: true

class UI::UseCase::ConvertUIHIFProject
  def execute(project_data:)
    @project = project_data
    @converted_project = {}

    convert_project_summary
    convert_infrastructures
    convert_funding_profiles
    convert_costs
    convert_baseline_cash_flow
    convert_recovery
    convert_s151
    convert_outputs_forecast
    convert_outputs_actuals

    @converted_project
  end

  private

  def convert_project_summary
    return if @project[:summary].nil?

    @converted_project[:summary] = {
      BIDReference: @project[:summary][:BIDReference],
      projectName: @project[:summary][:projectName],
      leadAuthority: @project[:summary][:leadAuthority],
      jointBidAreas: @project[:summary][:jointBidAreas],
      projectDescription: @project[:summary][:projectDescription],
      greenOrBrownField: @project[:summary][:greenOrBrownField],
      noOfHousingSites: @project[:summary][:noOfHousingSites],
      totalArea: @project[:summary][:totalArea],
      hifFundingAmount: @project[:summary][:hifFundingAmount],
      descriptionOfInfrastructure: @project[:summary][:descriptionOfInfrastructure],
      descriptionOfWiderProjectDeliverables: @project[:summary][:descriptionOfWiderProjectDeliverables]
    }

    @converted_project[:summary].compact!
  end

  def convert_infrastructures
    @converted_project[:infrastructures] = @project[:infrastructures].map do |infrastructure|
      converted_infrastructure = {}

      unless infrastructure[:summary].nil?
        converted_infrastructure[:type] = infrastructure[:summary][:type]
        converted_infrastructure[:description] = infrastructure[:summary][:description]
        converted_infrastructure[:housingSitesBenefitting] = infrastructure[:summary][:housingSitesBenefitting]

        unless infrastructure[:summary][:expectedInfrastructureStart].nil?
          converted_infrastructure[:expectedInfrastructureStart] = {
            targetDateOfAchievingStart: infrastructure[:summary][:expectedInfrastructureStart][:targetDateOfAchievingStart]
          }
        end

        unless infrastructure[:summary][:expectedInfrastructureCompletion].nil?
          converted_infrastructure[:expectedInfrastructureCompletion] = {
            targetDateOfAchievingCompletion: infrastructure[:summary][:expectedInfrastructureCompletion][:targetDateOfAchievingCompletion]
          }
        end
      end

      unless infrastructure[:planningStatus].nil?

        unless infrastructure[:planningStatus][:outlinePlanningStatus].nil?
          converted_infrastructure[:outlinePlanningStatus] = {
            granted: infrastructure[:planningStatus][:outlinePlanningStatus][:granted],
            reference: infrastructure[:planningStatus][:outlinePlanningStatus][:reference],
            targetSubmission: infrastructure[:planningStatus][:outlinePlanningStatus][:targetSubmission],
            targetGranted: infrastructure[:planningStatus][:outlinePlanningStatus][:targetGranted],
            summaryOfCriticalPath: infrastructure[:planningStatus][:outlinePlanningStatus][:summaryOfCriticalPath]
          }
        end

        unless infrastructure[:planningStatus][:fullPlanningStatus].nil?
          converted_infrastructure[:fullPlanningStatus] = {
            granted: infrastructure[:planningStatus][:fullPlanningStatus][:granted],
            grantedReference: infrastructure[:planningStatus][:fullPlanningStatus][:grantedReference],
            targetSubmission: infrastructure[:planningStatus][:fullPlanningStatus][:targetSubmission],
            targetGranted: infrastructure[:planningStatus][:fullPlanningStatus][:targetGranted],
            summaryOfCriticalPath: infrastructure[:planningStatus][:fullPlanningStatus][:summaryOfCriticalPath]
          }
        end
      end

      unless infrastructure[:s106].nil?
        converted_infrastructure[:s106] = {
          requirement: infrastructure[:s106][:requirement],
          summaryOfRequirement: infrastructure[:s106][:summaryOfRequirement]
        }
      end

      unless infrastructure[:statutoryConsents].nil?
        converted_infrastructure[:statutoryConsents] = {
          anyConsents: infrastructure[:statutoryConsents][:anyConsents],
          consents: infrastructure[:statutoryConsents][:consents].map do |consent|
            {
              detailsOfConsent: consent[:detailsOfConsent],
              targetDateToBeMet: consent[:targetDateToBeMet]
            }
          end
        }
      end

      unless infrastructure[:landOwnership].nil?
        converted_infrastructure[:landOwnership] = {
          underControlOfLA: infrastructure[:landOwnership][:underControlOfLA],
          ownershipOfLandOtherThanLA: infrastructure[:landOwnership][:ownershipOfLandOtherThanLA],
          landAcquisitionRequired: infrastructure[:landOwnership][:landAcquisitionRequired],
          howManySitesToAcquire: infrastructure[:landOwnership][:howManySitesToAcquire],
          toBeAcquiredBy: infrastructure[:landOwnership][:toBeAcquiredBy],
          targetDateToAcquire: infrastructure[:landOwnership][:targetDateToAcquire],
          summaryOfCriticalPath: infrastructure[:landOwnership][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:procurement].nil?
        converted_infrastructure[:procurement] = {
          contractorProcured: infrastructure[:procurement][:contractorProcured],
          nameOfContractor: infrastructure[:procurement][:nameOfContractor],
          targetDate: infrastructure[:procurement][:targetDate],
          summaryOfCriticalPath: infrastructure[:procurement][:summaryOfCriticalPath]
        }
      end

      unless infrastructure[:milestones].nil?
        converted_infrastructure[:milestones] = infrastructure[:milestones].map do |milestone|
          {
            descriptionOfMilestone: milestone[:descriptionOfMilestone],
            target: milestone[:target],
            summaryOfCriticalPath: milestone[:summaryOfCriticalPath]
          }
        end
      end

      unless infrastructure[:risksToAchievingTimescales].nil?
        converted_infrastructure[:risksToAchievingTimescales] = infrastructure[:risksToAchievingTimescales].map do |risk|
          {
            descriptionOfRisk: risk[:descriptionOfRisk],
            impactOfRisk: risk[:impactOfRisk],
            likelihoodOfRisk: risk[:likelihoodOfRisk],
            mitigationOfRisk: risk[:mitigationOfRisk]
          }
        end
      end

      converted_infrastructure.compact
    end
  end

  def convert_funding_profiles
    return if @project[:fundingProfiles].nil?
    return if @project[:fundingProfiles][:profiles].nil?

    @converted_project[:fundingProfiles] = []

    @converted_project[:fundingProfiles] = @project[:fundingProfiles][:profiles].map do |profile|
      next if profile.nil?
      {
        period: profile[:period],
        instalment1: profile[:instalment1],
        instalment2: profile[:instalment2],
        instalment3: profile[:instalment3],
        instalment4: profile[:instalment4],
        total: profile[:total]
    }.compact
    end
  end

  def convert_costs
    return if @project[:costs].nil?
    @converted_project[:costs] = []

    @converted_project[:costs] = @project[:costs].each do |cost|
      converted_cost = {}

      unless cost[:infrastructures].nil?
        converted_cost[:infrastructure] = {
          HIFAmount: cost[:infrastructure][:HIFAmount],
          totalCostOfInfrastructure: cost[:infrastructure][:totalCostOfInfrastructure],
          totallyFundedThroughHIF: cost[:infrastructure][:totallyFundedThroughHIF],
          descriptionOfFundingStack: cost[:infrastructure][:descriptionOfFundingStack],
          totalPublic: cost[:infrastructure][:totalPublic],
          totalPrivate: cost[:infrastructure][:totalPrivate]
        }
      end

      @converted_project[:costs] << converted_cost
    end
  end

  def convert_baseline_cash_flow
    return if @project[:baselineCashFlow].nil?

    @converted_project[:baselineCashFlow] = {
      summaryOfRequirement: @project[:baselineCashFlow][:summaryOfRequirement]
    }
  end

  def convert_recovery
    return if @project[:recovery].nil?

    @converted_project[:recovery] = {
      aimToRecover: @project[:recovery][:aimToRecover],
      expectedAmountToRecover: @project[:recovery][:expectedAmountToRecover],
      methodOfRecovery: @project[:recovery][:methodOfRecovery]
    }

    @converted_project[:recovery].compact!
  end

  def convert_s151
    return if @project[:s151].nil?

    @converted_project[:s151] = {
      s151FundingEndDate: @project[:s151][:s151FundingEndDate],
      s151ProjectLongstopDate: @project[:s151][:s151ProjectLongstopDate]
    }
  end

  def convert_outputs_forecast
    return if @project[:outputs][0][:outputsForecast].nil?

    @converted_project[:outputsForecast] = {
      totalUnits: @project[:outputs][0][:outputsForecast][:totalUnits],
      disposalStrategy: @project[:outputs][0][:outputsForecast][:disposalStrategy]
    }

    @converted_project[:outputsForecast].compact!

    return if @project[:outputs][0][:outputsForecast][:housingForecast].nil?

    @converted_project[:outputsForecast][:housingForecast] = @project[:outputs][0][:outputsForecast][:housingForecast][:forecast].map do |forecast|
      {
        period: forecast[:period],
        target: forecast[:target],
        housingCompletions: forecast[:housingCompletions]
      }
    end
  end

  def convert_outputs_actuals
    return if @project[:outputs][0][:outputsActuals].nil?

    @converted_project[:outputsActuals] = {}

    return if @project[:outputs][0][:outputsActuals][:siteOutputs].nil?

    @converted_project[:outputsActuals] = {
      siteOutputs: @project[:outputs][0][:outputsActuals][:siteOutputs].map do |output|
        {
          siteName: output[:siteName],
          siteLocalAuthority: output[:siteLocalAuthority],
          siteNumberOfUnits: output[:siteNumberOfUnits]
        }
      end
    }
  end
end