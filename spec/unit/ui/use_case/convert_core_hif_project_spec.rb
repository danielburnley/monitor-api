describe UI::UseCase::ConvertCoreHIFProject do
  let(:project_to_convert) do
    File.open("#{__dir__}/../../../fixtures/hif_baseline_core.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  let(:ui_data_project) do
    File.open("#{__dir__}/../../../fixtures/hif_baseline_ui.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  it 'Converts the project correctly' do
    converted_project = described_class.new.execute(project_data: project_to_convert)

    expect(converted_project).to eq(ui_data_project)
  end

  let(:nil_data_to_convert) do
    {
      outputsForecast: {
        housingForecast: nil
      }
    }
  end

  let(:returned_empty_project) do
    {
      infrastructures: [{}],
      outputs: [{
        outputsActuals: {},
        outputsForecast: {}
      }]
    }
  end

  it 'Converts nil data' do
    converted_project = described_class.new.execute(project_data: nil_data_to_convert)
    expect(converted_project).to eq(returned_empty_project)
  end
end
