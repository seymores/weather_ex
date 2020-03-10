defmodule WeatherEx do
  @moduledoc """
  Simple module to get major city current weather data, using openweathermap.org API.
  """

  @api_key "ba34beeddb042271dd2008c1ffc458aa"

  @doc """
  Returns the current weather data for Singapore, ID = 1880252
  """
  def singapore do
    weather_by_id(1880252, "api.openweathermap.org/data/2.5/forecast", @api_key)
  end

  @doc """
  Returns the current weather data for Hong Kong, ID = 1819729
  """
  def hong_kong do
    weather_by_id(1819729, "api.openweathermap.org/data/2.5/forecast", @api_key)
  end

  @doc """
  Generic HTTP GET with the given country/city id, base url, and api-key
  """
  @spec weather_by_id(number, String.t, String.t) :: any
  def weather_by_id(id, url, api_key \\ @api_key) do
    case HTTPoison.get("#{url}?id=#{id}&APPID=#{api_key}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body |> Poison.decode!()
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:error, :resource_not_found}
      {:error, _} -> {:error, :unhandled_error}
    end
  end
end
