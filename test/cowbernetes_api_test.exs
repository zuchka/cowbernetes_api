defmodule CowbernetesApiTest do
  use ExUnit.Case
  doctest CowbernetesApi

  test "greets the world" do
    assert CowbernetesApi.hello() == :world
  end
end
