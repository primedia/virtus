require 'spec_helper'

describe 'Using required attributes' do
  before do
    module Examples
      class User
        include Virtus.model(:strict => true)

        attribute :name, String
        attribute :age,  Integer, :required => false
      end
    end
  end

  it 'raises coercion error when required attribute is nil' do
    expect { Examples::User.new(:name => nil) }.to raise_error(Virtus::CoercionError, "Failed to coerce attribute `name' from nil into String")
  end

  it 'does not raise coercion error when not required attribute is nil' do
    user = Examples::User.new(:name => 'Jane', :age => nil)

    expect(user.name).to eql('Jane')
    expect(user.age).to be(nil)
  end
end

describe 'Using lazy coercion' do
  before do
    module Examples
      class User
        include Virtus.model(:lazy_coerce => true)

        attribute :name, String
        attribute :age,  Integer
      end
    end
  end

  it 'delays coercion to read time' do
    user = Examples::User.new(:name => 123)
    expect(user.instance_variable_get("@name")).to eq(123)
    expect(user.name).to eq("123")
  end
end
