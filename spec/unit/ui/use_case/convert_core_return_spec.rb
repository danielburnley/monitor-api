describe UI::UseCase::ConvertCoreReturn do
  context 'Example 1' do
    let(:convert_core_hif_return_spy) { spy(execute: { data: 'converted_return_data' })}
    let(:convert_core_ac_return_spy) { spy(execute: { data: 'converted_by_ac_return_data' })}
    let(:convert_core_ff_return_spy) { spy(execute: { data: 'converted by ff return data' })}
    let(:sanitise_data_spy) { spy(execute: {data: 'nonempty'}) }

    let(:use_case) do
      described_class.new(
        convert_core_hif_return: convert_core_hif_return_spy,
        convert_core_ac_return: convert_core_ac_return_spy,
        convert_core_ff_return: convert_core_ff_return_spy,
        sanitise_data: sanitise_data_spy
      )
    end

    it 'sanitises the data' do
      use_case.execute(type: 'hif', return_data: { some_data: 'data value' })

      expect(sanitise_data_spy).to have_received(:execute).with(
        data: { data: 'converted_return_data' }
      )
    end

    context 'HIF data' do
      let(:response) do
        use_case.execute(
          return_data: { wrong_data: 'needs to be converted' },
          type: 'hif'
          )
      end

      before { response }

      it 'Calls the convert core hif use case' do
        expect(convert_core_hif_return_spy).to have_received(:execute).with(
          return_data: { wrong_data: 'needs to be converted' }
        )
      end
    end

    context 'AC data' do
      let(:response) do
        use_case.execute(
          return_data: { wrong_data: 'needs to be converted' },
          type: 'ac'
          )
      end

      before { response }

      it 'Calls the convert core ac use case' do
        expect(convert_core_ac_return_spy).to have_received(:execute).with(
          return_data: { wrong_data: 'needs to be converted' }
        )
      end
    end

    context 'FF data' do
      let(:response) do
        use_case.execute(
          return_data: { wrong_data: 'needs to be converted' },
          type: 'ff'
          )
      end

      before { response }

      it 'Calls the convert core ff use case' do
        expect(convert_core_ff_return_spy).to have_received(:execute).with(
          return_data: { wrong_data: 'needs to be converted' }
        )
      end
    end

    context 'a different type of data' do
      let(:response) do
        use_case.execute(
          return_data: { wrong_data: 'needs to be converted' },
          type: 'different type '
          )
      end

      before { response }

      it 'doesnt call the convert hif use case' do
        expect(convert_core_hif_return_spy).not_to have_received(:execute)
      end
    end
  
    it 'returns the sanitised data' do
      response = use_case.execute(type: 'hif', return_data: { some_data: 'data value' })

      expect(response).to eq({data: 'nonempty'})
    end
  end

  context 'Example 2' do
    let(:convert_core_hif_return_spy) { spy(execute: { my_second_return: 'Also been converted'})}
    let(:convert_core_ac_return_spy) { spy(execute: { my_second_return: 'Also been converted (by ac)'})}
    let(:convert_core_ff_return_spy) { spy(execute: { my_second_return: 'Also been converted (by ff)' })}
    let(:sanitise_data_spy) { spy(execute: {data: 'no nils'}) }

    let(:use_case) do
      described_class.new(
        convert_core_hif_return: convert_core_hif_return_spy,
        convert_core_ac_return: convert_core_ac_return_spy,
        convert_core_ff_return: convert_core_ff_return_spy,
        sanitise_data: sanitise_data_spy
      )
    end

    it 'sanitises the data' do
      use_case.execute(type: 'hif', return_data: { some_data: 'data value' })

      expect(sanitise_data_spy).to have_received(:execute).with(
        data: {my_second_return: 'Also been converted'}
      )
    end

    context 'HIF data' do
      let(:response) do
        use_case.execute(
          return_data: { before_conversion: 'Must check type' },
          type: 'hif'
          )
      end

      before { response }

      it 'Calls the convert core hif use case' do
        expect(convert_core_hif_return_spy).to have_received(:execute).with(
          return_data: { before_conversion: 'Must check type' }
        )
      end
    end

    context 'AC data' do
      let(:response) do
        use_case.execute(
          return_data: { before_conversion: 'Must check type' },
          type: 'ac'
          )
      end

      before { response }

      it 'Calls the convert core ac use case' do
        expect(convert_core_ac_return_spy).to have_received(:execute).with(
          return_data: { before_conversion: 'Must check type' }
        )
      end
    end

    context 'FF data' do
      let(:response) do
        use_case.execute(
          return_data: { before_conversion: 'Must check type' },
          type: 'ff'
          )
      end

      before { response }

      it 'Calls the convert core ff use case' do
        expect(convert_core_ff_return_spy).to have_received(:execute).with(
          return_data: { before_conversion: 'Must check type' }
        )
      end
    end

    context 'a different type of data' do
      let(:response) do
        use_case.execute(
          return_data: { before_conversion: 'Must check type' },
          type: 'not another type'
          )
      end

      before { response }

      it 'doesnt call the convert hif use case' do
        expect(convert_core_hif_return_spy).not_to have_received(:execute)
      end
    end

      
    it 'returns the sanitised data' do
      response = use_case.execute(type: 'hif', return_data: { some_data: 'data value' })

      expect(response).to eq({data: 'no nils'})
    end
  end
end
