# frozen_string_literal: true

describe LocalAuthority::Gateway::HIFReturnsSchemaTemplate do
  let(:template) { described_class.new.execute }

  it 'returns a schema' do
    expect(template.schema).not_to be_nil
  end

  context 'Outputs Forecast tab' do
    it 'Does not contain the outputs forecast tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:outputsForecast)
    end

    it 'Contains the outputs forecast tab when enabled' do
      ENV['OUTPUTS_FORECAST_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:outputsForecast)

      ENV['OUTPUTS_FORECAST_TAB'] = nil
    end
  end

  context 'Wider Scheme tab' do
    it 'Does not contain the outputs forecast tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:widerSchema)
    end

    it 'Contains the outputs forecast tab when enabled' do
      ENV['WIDER_SCHEME_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:widerScheme)

      ENV['WIDER_SCHEME_TAB'] = nil
    end
  end

  context 'Hif Recovery tab' do
    it 'Does not contain the hif recovery tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:hifRecovery)
    end

    it 'Contains the outputs forecast tab when enabled' do
      ENV['HIF_RECOVERY_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:hifRecovery)

      ENV['HIF_RECOVERY_TAB'] = nil
    end
  end

  context 's151 Confirmation Tab' do
    it 'Does not contain the confirmation tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:s151Confirmation)
    end

    it 'Contains the confirmation tab when enabled' do
      ENV['CONFIRMATION_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:s151Confirmation)
    end
  end

  context 's151 tab' do
    it 'Does not contain the s151 tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:s151)
    end

    it 'Contains the s151 tab when enabled' do
      ENV['S151_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:s151)
    end
  end

  context 'RM Monthly Catchup tab' do
    it 'Does not contain the RM Monthly Catchup tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:rmMonthlyCatchup)
    end

    it 'Contains the RM Monthly Catchup tab when enabled' do
      ENV['RM_MONTHLY_CATCHUP_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:rmMonthlyCatchup)
    end
  end

  context 'MR Review tab' do
    it 'Does not contain the MR Review Catchup tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:reviewAndAssurance)
    end

    it 'Contains the RM Review Catchup tab when enabled' do
      ENV['MR_REVIEW_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:reviewAndAssurance)
    end
  end

  context 'Outputs actuals tab' do
    it 'Does not contain the outputs actuals tab when disabled' do
      expect(template.schema[:properties]).not_to have_key(:outputsActuals)
    end

    it 'Contains the outputs actuals tab when enabled' do
      ENV['OUTPUTS_ACTUALS_TAB'] = 'Yes'

      expect(template.schema[:properties]).to have_key(:outputsActuals)
    end
  end
end
