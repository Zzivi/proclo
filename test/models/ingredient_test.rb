require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  def setup
    @ingredient = ingredients(:lettuce)
  end

  test "should be valid" do
    assert @ingredient.valid?
  end

  test "name should be present" do
    @ingredient.name = "     "
    assert_not @ingredient.valid?
  end

  test "name should not be too long" do
    @ingredient.name = "a" * 51
    assert_not @ingredient.valid?
  end

  test "name should be unique" do
    duplicate_ingredient = @ingredient.dup
    duplicate_ingredient.name = @ingredient.name.upcase
    @ingredient.save
    assert_not duplicate_ingredient.valid?
  end

  test "measurement_type should have liquid as default value" do
    ingredient_with_default_values = ingredients(:ingredient_with_default_values)
    assert_equal('liquid', ingredient_with_default_values.measurement_type)
  end

  test "measurement_type with an invalid value" do
    assert_raises(ArgumentError) do
      @ingredient.measurement_type = 'invalid_measurement_type'
    end
  end

  test "measurement_type liquid is valid value" do
    @ingredient.measurement_type = 'liquid'
    assert @ingredient.valid?
  end

  test "measurement_type weight is valid value" do
    @ingredient.measurement_type = 'weight'
    assert @ingredient.valid?
  end

  test "measurement_type unit is valid value" do
    @ingredient.measurement_type = 'unit'
    assert @ingredient.valid?
  end

end
