RSpec.shared_context 'dependency factory' do
  include_context 'with database'

  def get_use_case(use_case)
    dependency_factory.get_use_case(use_case)
  end

  def get_gateway(gateway)
    dependency_factory.get_gateway(gateway)
  end

  let(:dependency_factory) do
    factory = ::DependencyFactory.new
    factory.database = database

    factory.default_dependencies
    factory
  end
end
