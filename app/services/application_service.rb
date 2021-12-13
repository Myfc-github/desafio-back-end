class ApplicationService
  Result = Struct.new(:success?, :data, :error)

  def self.call(...)
    new(...).call
  end
end
