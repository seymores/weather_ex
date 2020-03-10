defmodule WeatherExTest do
  use ExUnit.Case
  doctest WeatherEx

  test "gets Singapore weather data, happy path" do
    result = WeatherEx.singapore()
    assert Map.keys(result) == ["city", "cnt", "cod", "list", "message"]
    assert get_in(result, ["city", "country"]) == "SG"
  end

  test "gets Hong Kong weather data, happy path" do
    # wrong API version, returns 404 from openweathermap.org
    assert WeatherEx.weather_by_id(1819729, "api.openweathermap.org/data/2.5/forecast") |> get_in(["city", "country"]) == "HK"
  end

  test "module handles 404 error" do
    # wrong API version, returns 404 from openweathermap.org
    assert WeatherEx.weather_by_id(1819706, "api.openweathermap.org/data/3.0/forecast") == {:error, :resource_not_found}
  end

  test "module throws unhandled error, very unhappy path" do
    assert WeatherEx.weather_by_id(1819706, "api.openweathermap.wrongurl/data/2.5/forecast") == {:error, :unhandled_error}
  end
end
