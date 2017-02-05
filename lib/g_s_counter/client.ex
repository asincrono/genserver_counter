defmodule GSCounter.Client do
  def start_link(initial_value) do
    GenServer.start_link(GSCounter.Server, initial_value, [name: GSCounter.Sever])
  end

  def get(node \\ Node.self()) do
    GenServer.call({node, GSCounter.Server}, :get)
  end

  def increment(node \\ Node.self()) do
    GenServer.call({node, GSCounter.Server}, :increment)
  end

  def decrement(node \\ Node.self()) do
    GenServer.call({node, GSCounter.Server}, :decrement)
  end
end
