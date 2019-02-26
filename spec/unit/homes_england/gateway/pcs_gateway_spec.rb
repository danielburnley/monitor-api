describe HomesEngland::Gateway::Pcs do
  context 'Example 1' do
    let(:pcs_domain) { 'meow.cat' }
    let(:pcs_overview_request) do
      stub_request(
        :get,
        "https://#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F255"
      ).to_return(
        status: 200,
        body: {
          ProjectManager: "Ed",
          Sponsor: "FIS"
        }.to_json
      ).with(
        headers: {'Authorization' => 'Bearer M.R.I' }
      )
    end

    let(:pcs_actuals_request) do
      stub_request(
        :get,
        "https://#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F255/actuals"
      ).to_return(
        status: 200,
        body: [
          {
            dateInfo: {
              period: '2018/19'
            },
            payments: {
              currentYearPayments:
              [111900, 25565, 14159265]
            }
          }
        ].to_json
      ).with(
        headers: {'Authorization' => 'Bearer M.R.I' }
      )
    end

    let(:gateway) { described_class.new }

    before do
      ENV['PCS_DOMAIN'] = pcs_domain
      pcs_overview_request
      pcs_actuals_request
      gateway
    end

    it 'Calls the PCS overview endpoint' do
      gateway.get_project(bid_id: 'HIF/MV/255', pcs_key: 'M.R.I')
      expect(pcs_overview_request).to have_been_requested
    end

    it 'Calls the PCS actuals endpoint' do
      gateway.get_project(bid_id: 'HIF/MV/255', pcs_key: 'M.R.I')
      expect(pcs_actuals_request).to have_been_requested
    end

    it 'Returns a domain object' do
      project = gateway.get_project(bid_id: 'HIF/MV/255', pcs_key: 'M.R.I')

      expect(project.project_manager).to eq("Ed")
      expect(project.sponsor).to eq("FIS")
      expect(project.actuals).to eq([
        {
          dateInfo: {
            period: '2018/19'
          },
          payments: {
            currentYearPayments:
            [111900, 25565, 14159265]
          }
        }
      ])
    end
  end

  context 'Example 2' do
    let(:pcs_domain) { 'meow.space' }
    let(:pcs_overview_request) do
      stub_request(
        :get,
        "https://#{pcs_domain}/pcs-api/v1/Projects/AC%252FMV%252F151"
      ).to_return(
          status: 200, body: {
          ProjectManager: "Natalia",
          Sponsor: "NHN"
        }.to_json
      ).with(
        headers: {'Authorization' => 'Bearer C.C.G' }
      )
    end

    let(:pcs_actuals_request) do
      stub_request(
        :get,
        "https://#{pcs_domain}/pcs-api/v1/Projects/AC%252FMV%252F151/actuals"
      ).to_return(
        status: 200,
        body: [
          {
            dateInfo: {
              period: '2007/2008'
            },
            payments: {
              currentYearPayments:
              [800999, 41199, 1989, 2012]
            }
          }
        ].to_json
      ).with(
        headers: {'Authorization' => 'Bearer C.C.G' }
      )
    end

    let(:gateway) { described_class.new }

    before do
      ENV['PCS_DOMAIN'] = pcs_domain
      pcs_overview_request
      pcs_actuals_request
      gateway
    end

    it 'Calls the PCS overview endpoint' do
      gateway.get_project(bid_id: 'AC/MV/151', pcs_key: 'C.C.G')
      expect(pcs_overview_request).to have_been_requested
    end

    it 'Calls the PCS actuals endpoint' do
      gateway.get_project(bid_id: 'AC/MV/151', pcs_key: 'C.C.G')
      expect(pcs_actuals_request).to have_been_requested
    end

    it 'Returns a domain object' do
      project = gateway.get_project(bid_id: 'AC/MV/151', pcs_key: 'C.C.G')

      expect(project.project_manager).to eq("Natalia")
      expect(project.sponsor).to eq("NHN")
      expect(project.actuals).to eq([
        {
          dateInfo: {
            period: '2007/2008'
          },
          payments: {
            currentYearPayments:
            [800999, 41199, 1989, 2012]
          }
        }
      ])
    end
  end
end
