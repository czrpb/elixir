defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new() do
    %RemoteControlCar{
      battery_percentage: 100,
      distance_driven_in_meters: 0,
      nickname: "none"
    }
  end

  def new(nickname) do
    %RemoteControlCar{new() | nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    bat_per =
      case remote_car.battery_percentage do
        0 -> "empty"
        x -> "at #{x}%"
      end

    "Battery #{bat_per}"
  end

  def drive(
        %RemoteControlCar{battery_percentage: bp, distance_driven_in_meters: dist} = remote_car
      ) do
    if bp == 0 do
      remote_car
    else
      %{remote_car | battery_percentage: bp - 1, distance_driven_in_meters: dist + 20}
    end
  end
end
